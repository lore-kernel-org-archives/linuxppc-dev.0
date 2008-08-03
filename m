Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 26210DDDCA
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 04:45:07 +1000 (EST)
Received: from [192.168.1.37] (node197.74.251.72.1dial.com [72.251.74.197])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m73IabfJ067995
	for <linuxppc-dev@ozlabs.org>; Sun, 3 Aug 2008 11:37:52 -0700 (PDT)
Message-ID: <4895F9EB.8050508@hypersurf.com>
Date: Sun, 03 Aug 2008 11:33:15 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: to schedule() or not to schedule() ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,


	I have the following near the top of my cpufreq driver target routine:

while(test_and_set_bit(cf750gxmCfgChangeBit,&cf750gxvStateBits)) {
         /*
          * Someone mucking with our cfg? (I hope it is ok to call
          * schedule() here! - truth is I have no idea what I am doing
          * ... my reasoning is I want to yeild the cpu so whoever is
          * mucking around can finish)
          */
         schedule();
}

This is to prevent bad things from happening if someone is trying to 
change a parameter for the driver via sysfs while the target routine is 
running. Fortunately, because I had a bug where this bit was not getting 
cleared on one of the paths through the target routine ... I now know it 
is not safe to call schedule (it got stuck in there - knocked out my adb 
keyboard! - (I think target is called from a timer that the governor 
sets up ... interrupt context?)).

	How does one very briefly yield the cpu in this context?

kevin
