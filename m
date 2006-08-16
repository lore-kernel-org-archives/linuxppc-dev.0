Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id F07C567B68
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 07:48:55 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so319060ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 14:48:53 -0700 (PDT)
Message-ID: <528646bc0608161448y26e13398v3b818ed5f1124295@mail.gmail.com>
Date: Wed, 16 Aug 2006 15:48:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Clint Thomas" <cthomas@soneticom.com>
Subject: Re: Linux hanging on Xilinx SystemACE
In-Reply-To: <3C02138692C13C4BB675FE7EA240952918DBED@bluefin.Soneticom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3C02138692C13C4BB675FE7EA240952918DBED@bluefin.Soneticom.local>
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

On 8/16/06, Clint Thomas <cthomas@soneticom.com> wrote:
>
>
> Hey,
>
> Using the powerpc development tree of Linux 2.4, I am trying to boot my
> system from CompactFlash using Xilinx SystemACE. My compact flash card has
> two partitions, a 16MB FAT16 that holds the combination FPGA image / Linux
> Kernel ELF file, and an Ext2 partition that holds the root file system. The
> system starts the boot process, uncompresses the Linux kernel and begins
> loading drivers. Part way into this process, it conducts a partition check
> of the drive being reported to it by SystemACE, however, it hangs at that
> point. No kernel panic, no error message, it simply hangs. Here is the
> output at that point...
>
> Partition check:
>  xsysacea:
>
> what I am trying to find out is if this problem has been seen/fixed in the
> past? or did I format the CF card incorrectly?

Checking partitions is a user-space activity (fsck).  Remove it from
your init scripts.  Besides, unless your using a microdrive, your ext2
rootfs should be mounted read-only which greatly reduces the need for
fsck.  (because FLASH will wear out after too many writes)

Cheers,
g.
-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
