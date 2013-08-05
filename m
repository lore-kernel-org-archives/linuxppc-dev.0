Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 815B22C0097
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Aug 2013 03:10:54 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 5 Aug 2013 22:30:19 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AEE5E3940058
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Aug 2013 22:40:31 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r75HAYrv40698016
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Aug 2013 22:40:34 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r75HAbZo031486
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Aug 2013 22:40:38 +0530
Message-ID: <51FFDC8B.7010909@linux.vnet.ibm.com>
Date: Mon, 05 Aug 2013 22:40:35 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 00/11] Add compression support to pstore
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
 <51FA3B02.7060004@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CAA167@ORSMSX106.amr.corp.intel.com>
 <CA+8MBbLuhVDCb26ag3AH0vXrP4MXHLxS5aVn8pTi4=qL1NdR5w@mail.gmail.com>
 <CA+8MBbJ7x46FGC7dPSdNzf8z=fZz20w1kiNgnZr4QQB6SUELhg@mail.gmail.com>
In-Reply-To: <CA+8MBbJ7x46FGC7dPSdNzf8z=fZz20w1kiNgnZr4QQB6SUELhg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tony,

Thank you very much for testing my patches.

On Saturday 03 August 2013 03:42 AM, Tony Luck wrote:
> A quick experiment to use your patchset - but with compression
> disabled by tweaking this line in pstore_dump():
>
>      zipped_len = -1; //zip_data(dst, hsize + len);
>
> turned out well. This kernel dumps uncompressed dmesg blobs into pstore
> and gets them back out again.  So it seems likely that the problems are
> someplace in the compression/decompression code.

A quick look on my code suggests that problem could be in this part
of code.

In pstore_dump:

          if (zipped_len < 0) {
                         dst = psinfo->buf;
                         hsize = sprintf(dst, "%s#%d Part%d\n",
                                         why, oopscount, part);
                         size = psinfo->bufsize - hsize;
                         dst += hsize;
                         compressed = false;

                         if (!kmsg_dump_get_buffer(dumper, true, dst,
size, &len))
                                 break;
                 } else {
                         compressed = true;
      --->               len = zipped_len;
                 }

I am returning zipped_len as the length of the compressed data (which also
has hsize compressed). So returning hsize + len in pstore_write callback
will be wrong. It should just have been zipped_len. This might be adding
junk characters.

Can you please replace this hunk with:

                 if (zipped_len < 0) {
                         pr_err("Compression failed\n");
                         dst = psinfo->buf;
                         hsize = sprintf(dst, "%s#%d Part%d\n",
                                         why, oopscount, part);
                         size = psinfo->bufsize - hsize;
                         dst += hsize;
                         compressed = false;

                         if (!kmsg_dump_get_buffer(dumper, true, dst,
size, &len))
                                 break;
                         total_len = hsize + len;
                 } else {
                         compressed = true;
                         total_len = zipped_len;
                 }

                 ret = psinfo->write(PSTORE_TYPE_DMESG, reason, &id, part,
                                     oopscount, compressed, total_len, psinfo);
                 if (ret == 0 && reason == KMSG_DUMP_OOPS && pstore_is_mounted())
                         pstore_new_entry = 1;

                 total += total_len;
                 part++;

With the above hunk, atleast I dont see junk characters at the end in power.

I apologise, since I do not have the suitable machine to test this I am
not able to reproduce the scenarios you are stating. I need your help
in testing this.

- Aruna

> -Tony
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
