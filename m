Message-ID: <403E3170.3030507@ru.mvista.com>
Date: Thu, 26 Feb 2004 20:48:32 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Jeff Angielski <jeff@theptrgroup.com>
Cc: Stephen Williams <612dlag102@sneakemail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Activating SystemACE support
References: <10318-29667@sneakemail.com> <1077811344.4225.12.camel@localhost.localdomain>
In-Reply-To: <1077811344.4225.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeff Angielski wrote:
> On Wed, 2004-02-25 at 22:54, Stephen Williams wrote:
>
>>I have a board that, like the Xilinx ml300 board, has a SystemACE
>>chip on it. I would like to activate the existing SystemACE drivers
>>support in the kernel, but it is not clear to me how I pass to the
>>drivers the base address and IRQ that has been assigned. Does anyone
>>has any suggestions?
>>
>
>
> The SystemACE driver is currently written as a subset of the
> CONFIG_XILINX_OCP code.  So the easiest thing is to just add another
> xparameters_xxxx.h and have it conditionally included into the
> arch/ppc/platforms/xilinx_ocp/xparameters.h file.  Put your board
> specific information in that file and you should be fine from there.

Yes, this is what is expected for new boards.
When writing about how the existing SystemACE driver gets the base
address etc. from xparameters_ml300.h I haven't meant editing this file
to match someone's board configuration. Probably I should better refer
to xparameters.h.

>
> You might have to also munge the config.in files and/or Makefiles to
> make sure everything gets included that needs to be there to support the
> SystemACE.
>
> Incidentally, I would be interested in hearing what kind of transfer
> rates people are seeing using the SystemACE.  I have run some Bonnie
> tests on the filesystem on my MPC8266 board and it is pretty slow.

This is what I've got for ML300 (CPU clock is 300MHz, 1GB IBM MicroDrive disk):

Version  1.03      ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
192.168.119.11  20M           33448  96 31978  99           +++++ +++ 5342.4  97
192.168.119.11  20M           35652 100 33523  99           +++++ +++ 5685.3  95
192.168.119.11  20M           +++++ +++ 27207  69           40435  57 5758.6  90
192.168.119.11  20M           17465  51 27585  80           +++++ +++ 6479.5  96
192.168.119.11  20M           40164 100 38478  99           +++++ +++ 6604.3  98
                     ------Sequential Create------ --------Random Create--------
                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
192.168.119.11   16   189  96 +++++ +++  5909  74   191  92 26963  82   614  88
192.168.119.11   16   172  86 32531  99  7948  99   206  91 +++++ +++   747  90
192.168.119.11   16   195  87 +++++ +++  9156 100   207  90 +++++ +++   749  90
192.168.119.11   16   194  87 +++++ +++  6574  72   210  91 +++++ +++   719  87
192.168.119.11   16   189  86 +++++ +++  9152  99   208  91 +++++ +++   748  90

>
> Jeff Angielski
> The PTR Group
>
>
>

Best regards,
Andrei Konovalov


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
