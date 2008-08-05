Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 21014DDF01
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 04:38:02 +1000 (EST)
Message-ID: <48989DFE.7080506@nortel.com>
Date: Tue, 05 Aug 2008 12:37:50 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: to schedule() or not to schedule() ?
References: <4895F9EB.8050508@hypersurf.com>
In-Reply-To: <4895F9EB.8050508@hypersurf.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kevin Diggs wrote:
> Hi,
> 
> 
>     I have the following near the top of my cpufreq driver target routine:
> 
> while(test_and_set_bit(cf750gxmCfgChangeBit,&cf750gxvStateBits)) {
>         /*
>          * Someone mucking with our cfg? (I hope it is ok to call
>          * schedule() here! - truth is I have no idea what I am doing
>          * ... my reasoning is I want to yeild the cpu so whoever is
>          * mucking around can finish)
>          */
>         schedule();
> }
> 
> This is to prevent bad things from happening if someone is trying to 
> change a parameter for the driver via sysfs while the target routine is 
> running. Fortunately, because I had a bug where this bit was not getting 
> cleared on one of the paths through the target routine ... I now know it 
> is not safe to call schedule (it got stuck in there - knocked out my adb 
> keyboard! - (I think target is called from a timer that the governor 
> sets up ... interrupt context?)).

Is the issue that someone may be in the middle of a multi-stage 
procedure, and you've woken up partway through?

If so, what about simply rescheduling the timer for some short time in 
the future and aborting the current call?

Chris
