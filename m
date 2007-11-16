Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B74ADDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 21:30:11 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IsySe-0008Sh-5s
	for linuxppc-embedded@ozlabs.org; Fri, 16 Nov 2007 02:30:08 -0800
Message-ID: <13790720.post@talk.nabble.com>
Date: Fri, 16 Nov 2007 02:30:08 -0800 (PST)
From: Lorenz Kolb <linuxppcemb@lkmail.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Virtex TEMAC ping -s 10000 host, is it working?
In-Reply-To: <13770288.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13770288.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




alex_snippet wrote:
> 
> Hi All!
> 
> On Virtex 4FX board with TEMAC core, Linux ping working fine, but if s -
> parameter set to big values it freezes for ever...
> 
> Colleagues please share your experience with ping -s 10000 host.
> 
> Do you know what parameters in core or in Linux kernel must be changed to
> improve it.
> 
> My customer is too hypercritical, he likes to ping :(
> 
> I tried to  increase LX/TX buffers in core, it increased dead line but
> there is no desirable result.
> 
> 
> 


Hey, I can understand that customer, I like pinging as well.
And it works for me. Our design is based on ML403.
We use PLB_TEMAC (with minimum Fifos (4kB each)) and HardTEMAC


> .
> .
> .
> 10008 bytes from 192.168.0.206: icmp_seq=733 ttl=64 time=2.42 ms
> 10008 bytes from 192.168.0.206: icmp_seq=734 ttl=64 time=2.50 ms
> 10008 bytes from 192.168.0.206: icmp_seq=735 ttl=64 time=2.43 ms
> 10008 bytes from 192.168.0.206: icmp_seq=736 ttl=64 time=2.43 ms
> 10008 bytes from 192.168.0.206: icmp_seq=737 ttl=64 time=2.44 ms
> 10008 bytes from 192.168.0.206: icmp_seq=738 ttl=64 time=2.42 ms
> 10008 bytes from 192.168.0.206: icmp_seq=739 ttl=64 time=2.51 ms
> 10008 bytes from 192.168.0.206: icmp_seq=740 ttl=64 time=2.42 ms
> 10008 bytes from 192.168.0.206: icmp_seq=741 ttl=64 time=2.50 ms
> 10008 bytes from 192.168.0.206: icmp_seq=742 ttl=64 time=2.43 ms
> .
> .
> .
> 

And so on...


> --- 192.168.0.206 ping statistics ---
> 850 packets transmitted, 850 received, 0% packet loss, time 849010ms
> rtt min/avg/max/mdev = 2.399/11.623/1001.859/92.782 ms, pipe 3
> 
-- 
View this message in context: http://www.nabble.com/Virtex-TEMAC-ping--s-10000-host%2C-is-it-working--tf4812989.html#a13790720
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
