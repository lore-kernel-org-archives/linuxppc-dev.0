Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 3556367B6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 09:28:56 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so342916ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 16:28:54 -0700 (PDT)
Message-ID: <528646bc0608161628t2dc068d0g8862d8e8dd202170@mail.gmail.com>
Date: Wed, 16 Aug 2006 17:28:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Jeff Angielski" <jangiels@speakeasy.net>
Subject: Re: Linux hanging on Xilinx SystemACE
In-Reply-To: <1155766078.10357.16.camel@sumo-jaa>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3C02138692C13C4BB675FE7EA240952918DBED@bluefin.Soneticom.local>
	<1155766078.10357.16.camel@sumo-jaa>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/16/06, Jeff Angielski <jangiels@speakeasy.net> wrote:
> And like somebody else mentioned, if you are really going to use this
> for an embedded system, you are going to want to rethink your
> partitioning scheme.
>
> Maybe something like:
>
> p1 fat12 - kernel and binary image
> p2 ext2 - read only rootfs
> p3 ext3 - non volatile, slow rate data rootfs
> p4 tmpfs - volatile, high rate data rootfs

Or, if you have enough ram (and a small enough rootfs footprint); put
the rootfs into an initramfs and leave the CF alone entirely after
boot.  On small systems, I store all config parameters in a flat file
on the fat partition, and only write it out when it needs to save a
new configuration.  That way the entire system consists of three
files; a kernel, a rootfs image and a config file.  Makes managing
updates very easy.  :)

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
