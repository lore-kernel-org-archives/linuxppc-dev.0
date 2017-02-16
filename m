Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPDzk0Z1gzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:52:33 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GBnJox119854
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 06:52:32 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28n8jtfw30-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 06:52:31 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 21:52:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 44BDF2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:52:26 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GBqIL029229176
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:52:26 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GBprq7019694
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:51:54 +1100
Subject: Re: [PATCH] powerpc/xmon: Fix an unexpected xmon onoff state change
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <87shnek9hd.fsf@concordia.ellerman.id.au>
 <72cfff06-bd93-a727-0b93-31dfa3a7ac65@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 19:51:27 +0800
MIME-Version: 1.0
In-Reply-To: <72cfff06-bd93-a727-0b93-31dfa3a7ac65@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <8466dffc-d75c-d83a-2a4f-d567721db7d5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2017/2/16 18:57, Guilherme G. Piccoli 写道:
> On 16/02/2017 03:09, Michael Ellerman wrote:
>> Pan Xinhui <xinhui.pan@linux.vnet.ibm.com> writes:
>>
>>> Once xmon is triggered by sysrq-x, it is enabled always afterwards even
>>> if it is disabled during boot. This will cause a system reset interrut
>>> fail to dump. So keep xmon in its original state after exit.
>>>
>>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/xmon/xmon.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>>> index 9c0e17c..721212f 100644
>>> --- a/arch/powerpc/xmon/xmon.c
>>> +++ b/arch/powerpc/xmon/xmon.c
>>> @@ -76,6 +76,7 @@ static int xmon_gate;
>>>  #endif /* CONFIG_SMP */
>>>
>>>  static unsigned long in_xmon __read_mostly = 0;
>>> +static int xmon_off = 0;
>>>
>>>  static unsigned long adrs;
>>>  static int size = 1;
>>> @@ -3250,6 +3251,8 @@ static void sysrq_handle_xmon(int key)
>>>  	/* ensure xmon is enabled */
>>>  	xmon_init(1);
>>>  	debugger(get_irq_regs());
>>> +	if (xmon_off)
>>> +		xmon_init(0);
>>>  }
>>
>> I don't think this is right.
>>
>> xmon_off is only true if you boot with xmon=off on the command line.
>>
>> So if you boot with CONFIG_XMON_DEFAULT=n, and nothing on the command
>> line, then enter xmon via sysrq, then exit, xmon will still be enabled.
>>
>
> Agreed, noticed it after some work in V2 of my patch. I'm addressing it
> there, so maybe no harm in keeping this way here..
>
Hi, mpe
	I cooked a new patch. And as Paul mentioned in slack, we need keep xmon on too if xmon=early is set in cmdline.

hi, Guilherme
	feel free to include it in your new patchset. :)

thanks
xinhui

--------patch-----
powerpc/xmon: Fix an unexpected xmon onoff state change

Once xmon is triggered by sysrq-x, it is enabled always afterwards even
if it is disabled during boot. This will cause a system reset interrupt
fail to dump. So keep xmon in its original state after exit.

We have several ways to set xmon on or off.
1) by a build config CONFIG_XMON_DEFAULT.
2) by a boot cmdline with xmon or xmon=early or xmon=on to enable xmon
and xmon=off to disable xmon. This value will override that in step 1.
3) by a debugfs interface. We need someone implement it in the future.
And this value can override those in step 1 and 2.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
  arch/powerpc/xmon/xmon.c | 16 +++++++++-------
  1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17c..f6e5c3d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -76,6 +76,7 @@ static int xmon_gate;
  #endif /* CONFIG_SMP */
  
  static unsigned long in_xmon __read_mostly = 0;
+static int xmon_off = !IS_ENABLED(CONFIG_XMON_DEFAULT);
  
  static unsigned long adrs;
  static int size = 1;
@@ -3250,6 +3251,8 @@ static void sysrq_handle_xmon(int key)
  	/* ensure xmon is enabled */
  	xmon_init(1);
  	debugger(get_irq_regs());
+	if (xmon_off)
+		xmon_init(0);
  }
  
  static struct sysrq_key_op sysrq_xmon_op = {
@@ -3266,16 +3269,16 @@ static int __init setup_xmon_sysrq(void)
  __initcall(setup_xmon_sysrq);
  #endif /* CONFIG_MAGIC_SYSRQ */
  
-static int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early;
  
  static int __init early_parse_xmon(char *p)
  {
  	if (!p || strncmp(p, "early", 5) == 0) {
  		/* just "xmon" is equivalent to "xmon=early" */
-		xmon_init(1);
  		xmon_early = 1;
+		xmon_off = 0;
  	} else if (strncmp(p, "on", 2) == 0)
-		xmon_init(1);
+		xmon_off = 0;
  	else if (strncmp(p, "off", 3) == 0)
  		xmon_off = 1;
  	else if (strncmp(p, "nobt", 4) == 0)
@@ -3289,10 +3292,9 @@ early_param("xmon", early_parse_xmon);
  
  void __init xmon_setup(void)
  {
-#ifdef CONFIG_XMON_DEFAULT
-	if (!xmon_off)
-		xmon_init(1);
-#endif
+	if (xmon_off)
+		return;
+	xmon_init(1);
  	if (xmon_early)
  		debugger(NULL);
  }
-- 
2.9.3



> Thanks,
>
>
> Guilherme
>
>
>
>> cheers
>>
>
