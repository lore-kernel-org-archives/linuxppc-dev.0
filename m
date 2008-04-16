Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 59E57DE35A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 00:02:13 +1000 (EST)
Date: Wed, 16 Apr 2008 18:02:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] fsl_soc: Factor fsl_get_sys_freq() out of the wdt and
	spi inits.
Message-ID: <20080416140210.GA15529@polina.dev.rtsoft.ru>
References: <20080415185234.GA10579@loki.buserror.net>
	<20080415213221.GA2646@zarina> <48051FBA.1000801@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <48051FBA.1000801@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 15, 2008 at 04:35:54PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
>>> +u32 fsl_get_sys_freq(void)
>>> +{
>>> +	struct device_node *soc;
>>> +	const u32 *prop;
>>> +	int size;
>>> +
>>> +	if (sysfreq != -1)
>>> +		return sysfreq;
>>> +
>>> +	soc = of_find_node_by_type(NULL, "soc");
>>> +	if (!soc)
>>> +		return -1;
>>
>> Um.. can we finally decide on compatible for the soc nodes,
>> and add there compatible matching from the start?
>
> This is just a code reorganization; any change in what we match on  
> should be a separate patch.

Yes, it makes sense of course. Just wanted to get rid of the device_type
asap, because I'm going to submit mpc836x_rdk board, and I'd preferred to
submit it w/o device_type = "soc"... Oh well, ok.. later.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
