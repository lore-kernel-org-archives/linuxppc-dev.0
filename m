Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D8853DDF7F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 May 2008 14:11:53 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K0qXO-00055Q-Ml
	for linuxppc-embedded@ozlabs.org; Mon, 26 May 2008 21:11:50 -0700
Message-ID: <17482754.post@talk.nabble.com>
Date: Mon, 26 May 2008 21:11:50 -0700 (PDT)
From: swamydp <swamydp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
In-Reply-To: <17454696.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <17222725.post@talk.nabble.com>
	<20080514150139.E258D8D006F@mail70-va3.bigfish.com>
	<17276753.post@talk.nabble.com>
	<20080516162807.2132E181804D@mail89-sin.bigfish.com>
	<17454696.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi John

Please ignore my previous message. The kernel boots until initializing the
root files system and then hangs. Thats expected since I do not have root
file system set up yet. I dumped the __log_buf and found it. 

I don't understand why no message is printed by printk after "Now booting".
Does console init occur after root file system init ?

Thanks
swamy



swamydp wrote:
> 
> Hi John
> 
> Sorry for getting back late. 
> 
> I have been debugging further using the UART to send output directly to
> serial post. Now I see that just after entering start_kernel, a ITLB miss
> exception occurs and linux hangs at that point. 
> 
> Looks like the kernel is probably not running at all yet, may stuck in
> early initialization.
> 
>>> Yes
> 
> 1. Has the kernel ever ran on this board or is this development to get
> it running?
> 
>>> No. This is a new board and I am trying to build a simple EDK system
>>> with only
> PPC, UART, PIC as the devices.
>  
> 2. Not sure on the tools you are using to build it.  You mention the
> EDK, but you must not be using it's compiler as it's not configured in
> the EDK to build Linux. 
> 
>>> EDK 9.2 version, XMD for debug. Kernel 2.6 version is built in linux
>>> machine and zImage.elf is downloaded
> to the board.
> 
> Thanks for the UART suggestion, works well. Any suggestions as to what
> might be wrong in start_kernel function ? I will continue debugging
> meanwhile.
> 
> Thanks
> swamy
> 
> 
> 
> 

-- 
View this message in context: http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-board-tp17222725p17482754.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
