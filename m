Return-Path: <emrekara2002@yahoo.co.uk>
Received: from web25704.mail.ukl.yahoo.com (web25704.mail.ukl.yahoo.com
	[217.12.10.176]) by ozlabs.org (Postfix) with SMTP id 3E0C667A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 00:16:28 +1100 (EST)
Message-ID: <20050228131626.78019.qmail@web25704.mail.ukl.yahoo.com>
Date: Mon, 28 Feb 2005 13:16:26 +0000 (GMT)
From: emre kara <emrekara2002@yahoo.co.uk>
To: "Howell, Kyle" <Kyle.Howell@barco.com>
In-Reply-To: <7B9F5AC68255D7119B33000BCD4DAF8202BF7F9A@dulmex01.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: High processing power and gigabit interface
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone;
Thank you all for your valueable answers.
For summarizing the solutions, to overcome the problem
about getting high troughput on ethernet devices:
1- Use NAPI version of ethernet drivers(I didnt hear
its implemented for 440gx)
2- Change the processor with an much powerful one(like
8540, and I think there was also a NAPI driver for
this processor, so it can also cover the first
solution)
3- Use network processor

The third solution is an expensive one,my project is
not at that huge, so I eliminate this.
And my question, I have good hardware and mid level
linux device driver knowledge, but I never wrote an
ethernet driver.
Is there a lot of work for 440gx NAPI driver,can I
write it easly,if so where can I start,(or did someone
make it before?)
or must I throw 440gx eval board to waste basket and
buy a new platform?
Thank you all..
Emre

 
--- "Howell, Kyle" <Kyle.Howell@barco.com> wrote: 
> Hi Emre,
> 
> I am not familiar with the Linux network driver for
> the 440, but the first
> thing I would check is that your network driver is
> using the new NAPI. With
> packets as small as 64 bytes, this kind of interrupt
> traffic would floor any
> processor without some form of coalescing.
> 
> I am currently achieving ~800Mbits/sec throughput on
> a Motorola MPC8540
> @800MHz (very comparable to the 440, AFAIK). That
> project involves passing
> data from a non-network interface onto the network
> and vice-versa. Achieving
> that speed required using the NAPI version of the
> net driver and using 4KB
> packets (Jumbo packets). I don't know how great the
> hit would be if that was
> network-network traffic or if we were doing anything
> more complex than
> simple data routing.
> 
> I suspect that unless your encryption is hardware
> accelerated, you won't
> have a chance with anything less than a full
> multi-GHz processor. The other
> tasks could probably manage your required 200Mb/s on
> the 440 with enough
> tuning, though I'm not confident that would be true
> with packets as small as
> 64Bytes.
> 
> Regards,
> Kyle Howell
> Engineer, BarcoView LLC
> kyle.howell@barco.com
> 
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org]On
> Behalf Of emre kara
> Sent: Thursday, February 17, 2005 9:11 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: High processing power and gigabit interface
> 
> 
> Dear All,
> I'am not sure if this kind of question can be asked
> on
> this mail-list, if not, sorry about it.
> In my project, we need high processing power on
> gigabit network interfaces. our system will achive
> routing,nat, encryption at minimum 200 Mbits
> bandwith.
>  Firstly we decide to use amcc 440gx(ocotea)(because
> of TAH,2 gigabit interfaces etc..) and I had loaded
> linux kernel 2.6.10 and also denx's 2.4 kernel for
> our
> board..(with our (linux community) valueable
> helps..thanks alot..)
> I have tested 440gx routing performance with this
> two
> kernels, for doing this, we had send 64 bytes
> packets
> between two computer,but we could'nt see much more
> then 40Mbits routing performance on this tests. I
> think the problem with hardware, we have reached the
> limits.  
> I need your suggestions,which processor is suitable
> for our app or where am I wrong.
> Thanks alot for the answers.
> Emre
> 
> 
> 	
> 	
> 		
>
___________________________________________________________
> 
> ALL-NEW Yahoo! Messenger - all new features - even
> more fun!
> http://uk.messenger.yahoo.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  

Send instant messages to your online friends http://uk.messenger.yahoo.com 
