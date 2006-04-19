Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 9B4B5679F3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 07:21:10 +1000 (EST)
In-Reply-To: <4D8794260B62C940BBA7150CC5EB3BD432D512@bosmail.BOS.int.mrv.com>
References: <4D8794260B62C940BBA7150CC5EB3BD432D512@bosmail.BOS.int.mrv.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C8993021-BD00-4418-BF26-4BC8961BB53D@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: kernel 2.6.15: cpm_uart driver broken?
Date: Wed, 19 Apr 2006 17:14:27 -0400
To: Kenneth Poole <kpoole@mrv.com>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 19, 2006, at 4:40 PM, Kenneth Poole wrote:

> .....  we avoid having to do those
> conversions all of the time.

You are still doing a very similar conversion, only with
different addresses and offsets, and more compute
operations.

> I assumed that this test was simply to exclude console ports from
> conversion.

Bad assumption.  It's done to be able to use buffers allocated out
of the CPM memory or before the VM is sufficiently configured to
relocate the buffers.   This is needed for early debug prints, xmon,
and kgdb.

These modifications further remove features that have been
part of past kernels, and it has to stop.

Thanks.

	-- Dan
