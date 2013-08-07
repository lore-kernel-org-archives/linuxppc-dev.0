Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 399F12C0084
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 11:58:44 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 07:19:05 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3C3D73940058
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 07:28:17 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r771xZUo36700354
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 07:29:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r771wNL5010433
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 07:28:23 +0530
Message-ID: <5201A9BD.4090503@linux.vnet.ibm.com>
Date: Wed, 07 Aug 2013 07:28:21 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 00/11] Add compression support to pstore
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
 <51FA3B02.7060004@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CAA167@ORSMSX106.amr.corp.intel.com>
 <CA+8MBbLuhVDCb26ag3AH0vXrP4MXHLxS5aVn8pTi4=qL1NdR5w@mail.gmail.com>
 <CA+8MBbJ7x46FGC7dPSdNzf8z=fZz20w1kiNgnZr4QQB6SUELhg@mail.gmail.com>
 <51FFDC8B.7010909@linux.vnet.ibm.com>
 <CA+8MBb+1LpR+Cx=84WZT98U5eqZcm1KriUP75aCg+uSrXrb3Yw@mail.gmail.com>
 <51FFFFEB.3030907@linux.vnet.ibm.com>
 <CA+8MBbK9oZJO+RJGC-7riO=Kz=UbRcAvQ-nDi=2GLyvEDpoc7g@mail.gmail.com>
 <CA+8MBbKA+P4vs3utSKQ-LPMW3ybrWOp=f3FH6ahv1YtwnMm5KA@mail.gmail.com>
In-Reply-To: <CA+8MBbKA+P4vs3utSKQ-LPMW3ybrWOp=f3FH6ahv1YtwnMm5KA@mail.gmail.com>
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

On Wednesday 07 August 2013 05:06 AM, Tony Luck wrote:
> On Mon, Aug 5, 2013 at 2:20 PM, Tony Luck <tony.luck@gmail.com> wrote:
>> Still have problems booting if there are any compressed images in ERST
>> to be inflated.
> So I took another look at this part of the code ... and saw a couple of issues:
>
>          while ((size = psi->read(&id, &type, &count, &time, &buf, &compressed,
>                                  psi)) > 0) {
>                  if (compressed && (type == PSTORE_TYPE_DMESG)) {
>                          big_buf_sz = (psinfo->bufsize * 100) / 45;
>                          big_buf = allocate_buf_for_decompression(big_buf_sz);
>
>                          if (big_buf || stream.workspace)
>>>> Did you mean "&&" here rather that "||"?

Yes right, it should be &&.

>                                  unzipped_len = pstore_decompress(buf, big_buf,
>                                                          size, big_buf_sz);
>>>> Need an "else" here to set unzipped_len to -1 (or set it to -1 down
>>>> at the bottom of the loop ready for next time around.
>                          if (unzipped_len > 0) {
>                                  buf = big_buf;
>>>> This sets us up for problems.  First, you just overwrote the address
>>>> of the buffer that psi->read allocated - so we have a memory leak. But
>>>> worse than that we now double free the same buffer below when we
>>>> kfree(buf) and then kfree(big_buf)
>                                  size = unzipped_len;
>                                  compressed = false;
>                          } else {
>                                  pr_err("pstore: decompression failed;"
>                                          "returned %d\n", unzipped_len);
>                                  compressed = true;
>                          }
>                  }
>                  rc = pstore_mkfile(type, psi->name, id, count, buf,
>                                    compressed, (size_t)size, time, psi);
>                  kfree(buf);
>                  kfree(stream.workspace);
>                  kfree(big_buf);
>                  buf = NULL;
>                  stream.workspace = NULL;
>                  big_buf = NULL;
>                  if (rc && (rc != -EEXIST || !quiet))
>                          failed++;
>          }
>
>
> See attached patch that fixes these - but the code still looks like it
> could be cleaned up a bit more.

The patch looks right. I will clean it up. Does the issue still persist after this?

> -Tony
