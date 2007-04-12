Return-Path: <eswierk@arastra.com>
Received: from zimbra1.mindcentric.com (zimbra.mindcentric.com
	[216.98.159.230]) by ozlabs.org (Postfix) with ESMTP id A9232DDF14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 10:59:33 +1000 (EST)
From: Ed Swierk <eswierk@arastra.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Still trying to get a stable 2.6.20.4 running on 8349ITX eval
	board
Date: Wed, 11 Apr 2007 17:35:59 -0700
References: <OFA3732C99.56D7C409-ON882572BA.00702C6D-882572BA.00724020@selinc.com>
In-Reply-To: <OFA3732C99.56D7C409-ON882572BA.00702C6D-882572BA.00724020@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704111735.59170.eswierk@arastra.com>
Cc: Bruce_Leonard@selinc.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 11 April 2007 13:47:55 Bruce_Leonard@selinc.com wrote:
> Posted a cry for help a few days ago on this issue ;)> .  Got a couple of
> answers that didn't get me any farther so I'm on another fishing
> expedition.  Basic set up is as follows; MPC8349ITX eval board; 2.6.20.4
> kernel; a ubuntu/dapper FS via NFS.  The problem seems to be a random
> lock-up in either a DSI exception (0x300), a program exception (0x700) or
> a DTLB miss on store exception (0x1200).  I'm sure it's not truly random
> (I'm sure there's probably only a single underlying problem), but it's
> random in how it manifests.  When trying to mount the root FS via NFS, it
> always successfully reaches the point where it runs "/sbin/init" in
> main.c, but which script it fails in varies and it never gets to a login.

I spent about 8 hours yesterday tracking down a problem on a similar board 
(Embedded Planet 8343M) booting Fedora 6 via NFS. Linux was getting a bit 
farther along than it is for you--I got a shell and could run python--but the 
CPU kept locking up somewhere near 0x600 or 0x1200, without a peep from the 
kernel. It usually occurred after a lot of memory allocation activity, so I 
tried tracing the out-of-memory code in the kernel, but then found I could 
reproduce the problem with the mtest command in U-Boot.

The problem turned out to be an incorrect DDR SDRAM configuration setting in 
U-Boot for my board (which has no SPD EEPROM, so it's U-Boot's job to 
configure the memory controller). I was using CSCONFIG_ROW_BIT_12 rather than 
CSCONFIG_ROW_BIT_13 in CFG_DDR_CONFIG, which apparently affected the way the 
CPU accesses and refreshes the DRAM. I was pretty shocked that Linux was able 
to boot at all with a configuration bug like this.

Anyway, it might be worth double-checking the DDR SDRAM code in U-Boot to make 
sure it's doing the right thing for the parts on your board.

--Ed
