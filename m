Return-Path: <wg@grandegger.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E080EB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 18:27:00 +1000 (EST)
Message-ID: <4A56FB51.3050009@grandegger.com>
Date: Fri, 10 Jul 2009 10:26:57 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Bestcomm trouble with NAPI for MPC5200 FEC
References: <4A565423.6010207@grandegger.com>
	<20090710080830.GA3241@pengutronix.de>
In-Reply-To: <20090710080830.GA3241@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
> Hello Wolfgang,
> 
>> I'm currently trying to implement NAPI for the FEC on the MPC5200 to
>> solve the well known problem, that network packet storms can cause
>> interrupt flooding, which may totally block the system. The NAPI

Just bombard the FEC with network packets. I use pktgen on the host and
I could send you a script if you like.

> That's great news. Do you happen to have a scenario which reliably triggers the
> problem? Then I could do some testing as well. I haven't seen this on our
> boards for quite a while, but I'd like to verify.
> 
>> - With 2.6.31-rc2, the RFIFO error occurs quickly which does reset the
>>   FEC and Bestcomm (unfortunately, this does trigger an oops because
>>   it's called from the interrupt context, but that's another issue).
> 
> +1 for "error handling resets too much"

Yes, and furthermore it's leaking skb's :-(.

Wolfgang.
