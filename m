Return-Path: <rsc@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id CD9D8DE124
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 06:36:50 +1000 (EST)
Date: Tue, 19 May 2009 22:36:45 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Wolfram Sang <wsa@pengutronix.de>
Subject: Re: mpc5200 fec error
Message-ID: <20090519203645.GW19843@pengutronix.de>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
Cc: linuxppc-dev@ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfram, have you seen this mail? You recently tested -rt on 2.6.29,
right? Did you only test that on the customer hardware or also on the
phyCORE-MPC5200B?

rsc

On Mon, May 18, 2009 at 01:36:27PM -0400, Eric Millbrandt wrote:
> Hello all,
> 
>  
> 
> I am testing a 2.6.29.3 (with preempt_rt patches) kernel on a phytec pcm030 and
> am getting a kernel hang when testing the fec Ethernet controller.  The error
> only occurs when running the preempt-patched kernel, an unmodified kernel works
> fine.  Is anyone out there using preempt_rt on an MPC5200 successfully?
> 
>  
> 
> Eric
> 
>  
> 
> root@rudolph-ui:/root> iperf -c linux-5200bdevl01 -P 2 -i 1 -p 5001 -f k -t 600
> 
> ------------------------------------------------------------
> 
> Client connecting to linux-5200bdevl01, TCP port 5001
> 
> TCP window size: 36.2 KByte (default)
> 
> ------------------------------------------------------------
> 
> [  4] local 10.1.4.88 port 37872 connected with 10.1.5.234 port 5001
> 
> [  3] local 10.1.4.88 port 37871 connected with 10.1.5.234 port 5001
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  3]  0.0- 1.0 sec  3824 KBytes  31326 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  4]  0.0- 1.0 sec  3656 KBytes  29950 Kbits/sec
> 
> [SUM]  0.0- 1.0 sec  7480 KBytes  61276 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  4]  1.0- 2.0 sec  3760 KBytes  30802 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  3]  1.0- 2.0 sec  3752 KBytes  30736 Kbits/sec
> 
> [SUM]  1.0- 2.0 sec  7512 KBytes  61538 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  4]  2.0- 3.0 sec  3728 KBytes  30540 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  3]  2.0- 3.0 sec  3816 KBytes  31261 Kbits/sec
> 
> [SUM]  2.0- 3.0 sec  7544 KBytes  61800 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  3]  3.0- 4.0 sec  3712 KBytes  30409 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  4]  3.0- 4.0 sec  3824 KBytes  31326 Kbits/sec
> 
> [SUM]  3.0- 4.0 sec  7536 KBytes  61735 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  3]  4.0- 5.0 sec  3968 KBytes  32506 Kbits/sec
> 
> [ ID] Interval       Transfer     Bandwidth
> 
> [  4]  4.0- 5.0 sec  3624 KBytes  29688 Kbits/sec
> 
> [SUM]  4.0- 5.0 sec  7592 KBytes  62194 Kbits/sec
> 
> [ 5761.999175] net eth0: transmit queue overrun
> 
> [ 5762.003591] net eth0: transmit queue overrun
> 
> [ 5762.007948] net eth0: transmit queue overrun
> 
> [ 5762.012302] net eth0: transmit queue overrun
> 
> [ 5762.016658] net eth0: transmit queue overrun
> 
> [ 5762.021013] net eth0: transmit queue overrun
> 
> [ 5762.025381] net eth0: transmit queue overrun
> 
> [ 5762.029735] net eth0: transmit queue overrun
> 
> [ 5762.034090] net eth0: transmit queue overrun
> 
> [ 5762.038445] net eth0: transmit queue overrun
> 
> [ 5767.000928] net eth0: transmit queue overrun
> 
> [ 5767.005278] net eth0: transmit queue overrun
> 
> [ 5767.009634] net eth0: transmit queue overrun
> 
> [ 5767.013990] net eth0: transmit queue overrun
> 
> [ 5767.018345] net eth0: transmit queue overrun
> 
> [ 5767.022701] net eth0: transmit queue overrun
> 
> ?.
> 
> 
> 
> _____________________________________________________________________________
> 
> This e-mail and the information, including any attachments, it contains are
> intended to be a confidential communication only to the person or entity to
> whom it is addressed and may contain information that is privileged. If the
> reader of this message is not the intended recipient, you are hereby notified
> that any dissemination, distribution or copying of this communication is
> strictly prohibited. If you have received this communication in error, please
> immediately notify the sender and destroy the original message.
> 
> Thank you.        
> 
> 
> 
> Please consider the environment before printing this email.
> 

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
