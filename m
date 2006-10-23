Return-Path: <pantelis.antoniou@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id E2C0967B99
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 02:09:06 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so1112910ugc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Oct 2006 09:09:05 -0700 (PDT)
In-Reply-To: <f20416350610230902y78bd6740qc34e407004d6d511@mail.gmail.com>
References: <f20416350610230902y78bd6740qc34e407004d6d511@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <247D8ECE-79CC-4BA2-A902-D86802E50335@gmail.com>
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: CPM2 (MPC8260) SMC problem. Please help.
Date: Mon, 23 Oct 2006 19:09:00 +0300
To: Greg Lopp <lopp@pobox.com>
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


On 23 =CE=9F=CE=BA=CF=84 2006, at 7:02 =CE=9C=CE=9C, Greg Lopp wrote:

>> On Wed, 18 Oct 2006 22:40:31 +0200
>> Boris Shteinbock <boris at fabiotec.com> wrote:
>>
>>> Hi ppl.
>>>
>>> I have discovered very very odd problem with SMC2 on my 8260 board.
>>> kernel version is 2.6.17.
>>>
>>> The board is 8260 with serial ports on SMC1 and SMC 2 (SMC1 - =20
>>> console)
>>>
>>> Now if I use SMC2 for communicating with remote device, ( some =20
>>> protocol)
>>> I am sending packets and wait for a response.
>>> However if the packet I send is SMALLER than 5 bytes, SMC goes
>>> completely crazy.
>>> write() doesn't return error, but the next read() hangs =20
>>> completely, and the
>>> process moves to D state and it is impossible to kill it by any =20
>>> means.
>>> It only happens when consequent writes of smaller than 5 bytes.
>>> I tried to check the driver, but couldn't find any clues to what =20
>>> goes wrong.
>>>
>>> I tried both compatibility and platform-based modes with the same =20=

>>> results.
>>>
>>> Any help on the issue would be highliy appreciated.
>>>
>>>
>>
>> I think that should be walked along the cpm_uart driver, TX part =20
>> to see is sending stuff
>> do not indicate any error in the CPM registers, or at least =20
>> discover exact track leading to the endless loop.
>
> HI. I'm new here, but I encounted a very similar problem late last =20
> week....
>
> Boris, I am willing to bet that your problem lies with the return
> value from cpm_uart_tx_pump().  Here's the last few lines of that
> function from 2.6.17 :
> 693         if (uart_circ_empty(xmit)) {
> 694                 cpm_uart_stop_tx(port);
> 695                 return 0;
> 696         }
> 697
> 698         return 1;
> 699 }
> Note that return value is 0 if there is no more data in the tty's
> circular queue (uart_circ_empty() returns true)  This is the case when
> you send a small packet.  It seems appropriate to turn off the
> transmitter (cpm_uart_stop_tx()) in the general case, but the problem
> is that you never turned on the transmitter in the first place.....you
> called cpm_uart_tx_pump() from cpm_uart_start_tx() like so:
> 195         if (cpm_uart_tx_pump(port) !=3D 0) {
> 196                 if (IS_SMC(pinfo)) {
> 197                         smcp->smc_smcm |=3D SMCM_TX;
> 198                         smcp->smc_smcmr |=3D SMCMR_TEN;
> 199                 } else {
> 200                         sccp->scc_sccm |=3D UART_SCCM_TX;
> 201                         pinfo->sccp->scc_gsmrl |=3D SCC_GSMRL_ENT;
> 202                 }
> 203         }
>
> When you then attempt to close the port, you'll get stuck here, in
> cpm_uart_shutdown():
> 455                 /* Wait for all the BDs marked sent */
> 456                 while(!cpm_uart_tx_empty(port)) {
> 457                         set_current_state(TASK_UNINTERRUPTIBLE);
> 458                         schedule_timeout(2);
> 459                 }
> Because the transmitter was never turned on, the bd will never be
> processed by the CPM and cpm_uart_tx_empty() will always return false.
>
> Recommendation: Change the first block of code above to: "return
> (count !=3D 0);"  Now cpm_uart_tx_pump() will return true if data was
> placed in a bd, instead of true when there is more data to be
> processed later.  This code works for me - but there are folks on this
> list who would have a better idea about possible side
> effects........anyone?

Yes, sounds true.

Since I was responsible for that, hand me the brown paper bag...

/me wears it.

Please send me a patch to process it.

Regards

Pantelis
