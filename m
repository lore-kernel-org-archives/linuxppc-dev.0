Return-Path: <bwarren@qstreams.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 3A91767B8B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 00:14:57 +1000 (EST)
Subject: Re: problems with mounting JFFS2 using CFI for AM29LV160MT on
	ppc8245 k2.4.x
From: Ben Warren <bwarren@qstreams.com>
To: Arun Kumar <arunkat@gmail.com>
In-Reply-To: <edd12c050607240124gd001d11q77796ab4d13c241b@mail.gmail.com>
References: <edd12c050607210756h71bab7f8ve323edf3bf6077c6@mail.gmail.com>
	<1153498817.19682.149.camel@saruman.qstreams.net>
	<edd12c050607240124gd001d11q77796ab4d13c241b@mail.gmail.com>
Content-Type: multipart/alternative; boundary="=-uCDnvroNk19VB/L0RtWm"
Date: Mon, 24 Jul 2006 10:14:54 -0400
Message-Id: <1153750494.12540.23.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-uCDnvroNk19VB/L0RtWm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Arun,

Looks like there are still some things broken in your MTD partition
definition.  I highly recommend that when debugging this, you boot from
an NFS mount.  That way you can modify files off-line (ie. from your
development host).  I'll point out a few things, but you're going to
have to surf the source code a bit:

On Mon, 2006-07-24 at 13:54 +0530, Arun Kumar wrote:

> Hi Ben ,
> 
> Thanks for your reply .It was indeed very comrehensive .I am able to
> proceed further But still there is a bit problem .
> 
> When I try to mknod physically viz mknod /dev/mtd0 .....
> 
> It says the node is readonly . 
> 
> Can you please point out the problem . I am attaching a dump of the
> console .

Again, put your root FS on an NFS mount and this won't be an issue.  You
can work out the ramdisk details later.


>  AMD_FLASH_INIT called  *aks *
> physmap flash device: 800000 at ff800000 virtual address Number of
> erase regions
> : 4
> Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
> Primary Algorithm Table at 0040
> Alternative Vendor Command Set: 0000 (None)
> No Alternate Algorithm Table
> Vcc Minimum: 2.7 V
> Vcc Maximum: 3.6 V
> No Vpp line
> Typical byte/word write timeout: 128 µs
> Maximum byte/word write timeout: 256 µs
> Full buffer write not supported
> Typical block erase timeout: 1024 ms
> Maximum block erase timeout: 16384 ms
> Chip erase not supported
> Device size: 0x200000 bytes (2 MiB)
> Flash Device Interface description: 0x0002
>   - supports x8 and x16 via BYTE# with asynchronous interface
> Max. bytes in buffer write: 0x1
> Number of Erase Block Regions: 4
>   Erase Region #0: BlockSize 0x4000 bytes, 1 blocks
>   Erase Region #1: BlockSize 0x2000 bytes, 2 blocks
>   Erase Region #2: BlockSize 0x8000 bytes, 1 blocks
>   Erase Region #3: BlockSize 0x10000 bytes, 31 blocks
>  Amd/Fujitsu Extended Query Table v1.3 at 0x0040
> number of CFI chips: 4
> 
>  in amdstd_setup 0: offset=0x0,size=0x10000,blocks=1
> 1: offset=0x10000,size=0x8000,blocks=2
> 2: offset=0x20000,size=0x20000,blocks=1
> 3: offset=0x40000,size=0x40000,blocks=31
> 4: offset=0x800000,size=0x10000,blocks=1
> 5: offset=0x810000,size=0x8000,blocks=2
> 6: offset=0x820000,size=0x20000,blocks=1
> 7: offset=0x840000,size=0x40000,blocks=31
> 8: offset=0x1000000,size=0x10000,blocks=1
> 9: offset=0x1010000,size=0x8000,blocks=2
> 10: offset=0x1020000,size=0x20000,blocks=1
> 11: offset=0x1040000,size=0x40000,blocks=31
> 12: offset=0x1800000,size=0x10000,blocks=1
> 13: offset=0x1810000,size=0x8000,blocks=2
> 14: offset=0x1820000,size=0x20000,blocks=1
> 15: offset=0x1840000,size=0x40000,blocks=31
> cfi_cmdset_0002: Disabling fast programming due to code brokenness.
> aks Enabling
> *

Are you sure you have the correct chip family chosen in your CONFIG?
The block sizes found by CFI are different than those mentioned in
amdstd_setup...  CFI shows your devices being 2MB in size, while the
other shows (1*10000 + 2*8000 + 1*20000 + 31*40000 = 0x800000) 8MB per
chip.  Something is amiss here.  I don't have a clue about the fast
programming.  'grep -R' is your friend.

> 
>  in MTD Partitioning <5>No RedBoot partition table detected in
> phys_mapped_flash
> 
> Using physmap partition definition
> Creating 3 MTD partitions on "phys_mapped_flash":
> 0x00000000-0x00040000 : "agere-ets0"
> mtd: Giving out device 0 to agere-ets0
> 0x00040000-0x00080000 : "agere-ets1"
> mtd: Giving out device 1 to agere-ets1
> 0x00080000-0x0007fffe : "agere-ets2"
> mtd: partition "agere-ets2" doesn't end on an erase block -- force
> read-only

There's definitely a problem here.  First of all, 0x7fffe is < 0x80000.
Note that the start and end addresses you specify for this must be on
erase block boundaries.  Clean up your partition table to reflect what
you want.  You didn't mention whether you're passing partition info by
command line or in init code.  Also, if you're not using Redboot, get
rid of that CONFIG option.

regards,
Ben


--=-uCDnvroNk19VB/L0RtWm
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.10.2">
</HEAD>
<BODY>
Arun,<BR>
<BR>
Looks like there are still some things broken in your MTD partition definition.&nbsp; I highly recommend that when debugging this, you boot from an NFS mount.&nbsp; That way you can modify files off-line (ie. from your development host).&nbsp; I'll point out a few things, but you're going to have to surf the source code a bit:<BR>
<BR>
On Mon, 2006-07-24 at 13:54 +0530, Arun Kumar wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">Hi Ben ,</FONT><BR>
    <BR>
    <FONT COLOR="#000000">Thanks for your reply .It was indeed very comrehensive .I am able to proceed further But still there is a bit problem .</FONT><BR>
    <BR>
    <FONT COLOR="#000000">When I try to mknod physically viz mknod /dev/mtd0 .....</FONT><BR>
    <BR>
    <FONT COLOR="#000000">It says the node is readonly . </FONT><BR>
    <BR>
    <FONT COLOR="#000000">Can you please point out the problem . I am attaching a dump of the console .</FONT><BR>
</BLOCKQUOTE>
Again, put your root FS on an NFS mount and this won't be an issue.&nbsp; You can work out the ramdisk details later.<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;AMD_FLASH_INIT called&nbsp; *aks *</FONT><BR>
    <FONT COLOR="#000000">physmap flash device: 800000 at ff800000 virtual address Number of erase regions</FONT><BR>
    <FONT COLOR="#000000">: 4</FONT><BR>
    <FONT COLOR="#000000">Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)</FONT><BR>
    <FONT COLOR="#000000">Primary Algorithm Table at 0040</FONT><BR>
    <FONT COLOR="#000000">Alternative Vendor Command Set: 0000 (None)</FONT><BR>
    <FONT COLOR="#000000">No Alternate Algorithm Table</FONT><BR>
    <FONT COLOR="#000000">Vcc Minimum: 2.7 V</FONT><BR>
    <FONT COLOR="#000000">Vcc Maximum: 3.6 V</FONT><BR>
    <FONT COLOR="#000000">No Vpp line</FONT><BR>
    <FONT COLOR="#000000">Typical byte/word write timeout: 128 &#181;s</FONT><BR>
    <FONT COLOR="#000000">Maximum byte/word write timeout: 256 &#181;s</FONT><BR>
    <FONT COLOR="#000000">Full buffer write not supported</FONT><BR>
    <FONT COLOR="#000000">Typical block erase timeout: 1024 ms</FONT><BR>
    <FONT COLOR="#000000">Maximum block erase timeout: 16384 ms</FONT><BR>
    <FONT COLOR="#000000">Chip erase not supported</FONT><BR>
    <FONT COLOR="#000000">Device size: 0x200000 bytes (2 MiB)</FONT><BR>
    <FONT COLOR="#000000">Flash Device Interface description: 0x0002</FONT><BR>
    <FONT COLOR="#000000">&nbsp; - supports x8 and x16 via BYTE# with asynchronous interface</FONT><BR>
    <FONT COLOR="#000000">Max. bytes in buffer write: 0x1</FONT><BR>
    <FONT COLOR="#000000">Number of Erase Block Regions: 4</FONT><BR>
    <FONT COLOR="#000000">&nbsp; Erase Region #0: BlockSize 0x4000 bytes, 1 blocks</FONT><BR>
    <FONT COLOR="#000000">&nbsp; Erase Region #1: BlockSize 0x2000 bytes, 2 blocks</FONT><BR>
    <FONT COLOR="#000000">&nbsp; Erase Region #2: BlockSize 0x8000 bytes, 1 blocks</FONT><BR>
    <FONT COLOR="#000000">&nbsp; Erase Region #3: BlockSize 0x10000 bytes, 31 blocks</FONT><BR>
    <FONT COLOR="#000000">&nbsp;Amd/Fujitsu Extended Query Table v1.3 at 0x0040</FONT><BR>
    <FONT COLOR="#000000">number of CFI chips: 4</FONT><BR>
    <BR>
    <FONT COLOR="#000000">&nbsp;in amdstd_setup 0: offset=0x0,size=0x10000,blocks=1</FONT><BR>
    <FONT COLOR="#000000">1: offset=0x10000,size=0x8000,blocks=2</FONT><BR>
    <FONT COLOR="#000000">2: offset=0x20000,size=0x20000,blocks=1</FONT><BR>
    <FONT COLOR="#000000">3: offset=0x40000,size=0x40000,blocks=31</FONT><BR>
    <FONT COLOR="#000000">4: offset=0x800000,size=0x10000,blocks=1</FONT><BR>
    <FONT COLOR="#000000">5: offset=0x810000,size=0x8000,blocks=2</FONT><BR>
    <FONT COLOR="#000000">6: offset=0x820000,size=0x20000,blocks=1</FONT><BR>
    <FONT COLOR="#000000">7: offset=0x840000,size=0x40000,blocks=31</FONT><BR>
    <FONT COLOR="#000000">8: offset=0x1000000,size=0x10000,blocks=1</FONT><BR>
    <FONT COLOR="#000000">9: offset=0x1010000,size=0x8000,blocks=2</FONT><BR>
    <FONT COLOR="#000000">10: offset=0x1020000,size=0x20000,blocks=1</FONT><BR>
    <FONT COLOR="#000000">11: offset=0x1040000,size=0x40000,blocks=31</FONT><BR>
    <FONT COLOR="#000000">12: offset=0x1800000,size=0x10000,blocks=1</FONT><BR>
    <FONT COLOR="#000000">13: offset=0x1810000,size=0x8000,blocks=2</FONT><BR>
    <FONT COLOR="#000000">14: offset=0x1820000,size=0x20000,blocks=1</FONT><BR>
    <FONT COLOR="#000000">15: offset=0x1840000,size=0x40000,blocks=31</FONT><BR>
    <FONT COLOR="#000000">cfi_cmdset_0002: Disabling fast programming due to code brokenness. aks Enabling</FONT><BR>
    <FONT COLOR="#000000">*</FONT><BR>
</BLOCKQUOTE>
Are you sure you have the correct chip family chosen in your CONFIG?&nbsp; The block sizes found by CFI are different than those mentioned in amdstd_setup...&nbsp; CFI shows your devices being 2MB in size, while the other shows (1*10000 + 2*8000 + 1*20000 + 31*40000 = 0x800000) 8MB per chip.&nbsp; Something is amiss here.&nbsp; I don't have a clue about the fast programming.&nbsp; 'grep -R' is your friend.<BR>
<BLOCKQUOTE TYPE=CITE>
    <BR>
    <FONT COLOR="#000000">&nbsp;in MTD Partitioning &lt;5&gt;No RedBoot partition table detected in phys_mapped_flash</FONT><BR>
    <BR>
    <FONT COLOR="#000000">Using physmap partition definition</FONT><BR>
    <FONT COLOR="#000000">Creating 3 MTD partitions on &quot;phys_mapped_flash&quot;:</FONT><BR>
    <FONT COLOR="#000000">0x00000000-0x00040000 : &quot;agere-ets0&quot;</FONT><BR>
    <FONT COLOR="#000000">mtd: Giving out device 0 to agere-ets0</FONT><BR>
    <FONT COLOR="#000000">0x00040000-0x00080000 : &quot;agere-ets1&quot;</FONT><BR>
    <FONT COLOR="#000000">mtd: Giving out device 1 to agere-ets1</FONT><BR>
    <FONT COLOR="#000000">0x00080000-0x0007fffe : &quot;agere-ets2&quot;</FONT><BR>
    <FONT COLOR="#000000">mtd: partition &quot;agere-ets2&quot; doesn't end on an erase block -- force read-only</FONT><BR>
</BLOCKQUOTE>
There's definitely a problem here.&nbsp; First of all, 0x7fffe is &lt; 0x80000.&nbsp; Note that the start and end addresses you specify for this must be on erase block boundaries.&nbsp; Clean up your partition table to reflect what you want.&nbsp; You didn't mention whether you're passing partition info by command line or in init code.&nbsp; Also, if you're not using Redboot, get rid of that CONFIG option.<BR>
<BR>
regards,<BR>
Ben<BR>
<BR>
</BODY>
</HTML>

--=-uCDnvroNk19VB/L0RtWm--
