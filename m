Return-Path: <tony.luck@gmail.com>
Received: from mail-vb0-x236.google.com (mail-vb0-x236.google.com
 [IPv6:2607:f8b0:400c:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5F542C0096
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Aug 2013 08:12:40 +1000 (EST)
Received: by mail-vb0-f54.google.com with SMTP id q14so1194627vbe.27
 for <linuxppc-dev@ozlabs.org>; Fri, 02 Aug 2013 15:12:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+8MBbLuhVDCb26ag3AH0vXrP4MXHLxS5aVn8pTi4=qL1NdR5w@mail.gmail.com>
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
 <51FA3B02.7060004@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CAA167@ORSMSX106.amr.corp.intel.com>
 <CA+8MBbLuhVDCb26ag3AH0vXrP4MXHLxS5aVn8pTi4=qL1NdR5w@mail.gmail.com>
Date: Fri, 2 Aug 2013 15:12:38 -0700
Message-ID: <CA+8MBbJ7x46FGC7dPSdNzf8z=fZz20w1kiNgnZr4QQB6SUELhg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Add compression support to pstore
From: Tony Luck <tony.luck@gmail.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "keescook@chromium.org" <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A quick experiment to use your patchset - but with compression
disabled by tweaking this line in pstore_dump():

    zipped_len = -1; //zip_data(dst, hsize + len);

turned out well. This kernel dumps uncompressed dmesg blobs into pstore
and gets them back out again.  So it seems likely that the problems are
someplace in the compression/decompression code.

-Tony
