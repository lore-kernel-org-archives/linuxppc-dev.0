Subject: Re: DOC2000 unstable problem!!!
From: David Woodhouse <dwmw2@infradead.org>
To: leo <leo_guo@jisung.cn>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <200404201305.IAA27777@lists.linuxppc.org>
References: <200404201305.IAA27777@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1083252749.31783.35.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 29 Apr 2004 16:36:24 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-04-20 at 21:03 +0800, leo wrote:
> Hi all,
> I am porting linux to my MPC852 board, and linux now can runs ok, but it
> seems that the DOC2000 is unstable! My system config as follows:
>
> MCU: MPC852T 80M
> SDRAM: 32MB
> FLASH: 2MB
> DOC2000: 32MB
>
> I make a EXT2 file system on DOC2000, but sometimes, turn off the
> board's power when linux is running, and then turn on the power, the
> linux can't mount the root filesystem!
>
> Could you give me some advices? And I want know between the NAND flash
> and DOC, which is the better selection?

The DiskOnChip _is_ NAND flash. It's just typically used with its own
'translation layer' which pretends to be a block device.

If you're willing to put a small amount of effort into completing the
bad-block-table support in the new DiskOnChip driver which uses the
generic NAND code, you can use JFFS2 on it.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
