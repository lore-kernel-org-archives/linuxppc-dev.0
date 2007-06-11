Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id DAD87DDEE1
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 21:25:13 +1000 (EST)
Date: Mon, 11 Jun 2007 13:25:08 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] Add the support of ST M48T59 RTC chip in
	rtc-class driver subsystem
Message-ID: <20070611132508.0993a0f7@inspiron>
In-Reply-To: <1181548600.5217.16.camel@mark>
References: <1181548600.5217.16.camel@mark>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Jun 2007 15:56:40 +0800
Mark Zhan <rongkai.zhan@windriver.com> wrote:

> 
> Add the support of ST M48T59 RTC chip driver in RTC class subsystem for
> Wind River SBC PowerQUICCII 82xx board

 Hello Mark, thanks for you contribution. Code looks
 good, I only have some minor comments:

>  
> +config RTC_DRV_M48T59
> +	tristate "ST M48T59"
> +	depends on RTC_CLASS
> +	help
> +	  If you say Y here you will get support for the
> +	  ST M48T59 RTC chip.
> +
> +	  This driver can also be built as a module, if so, the module
> +	  will be called "rtc-m48t59".

 Please add some infos about the Wind River board in the help.

> +
> +#ifdef DEBUG_M48T59
> +#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: "fmt,
> __FUNCTION__, ##args)
> +#else
> +#define DPRINTK(fmt, args...)
> +#endif

 please use standard device debugging/reporting functions


> +
> +static unsigned char * m48t59_vbase = NULL;
> +static unsigned int m48t59_irq = -1;

 those shouldn't be globals. please see other drivers for suggestions
 on encapsulation.

> +static int m48t59_rtc_proc(struct device *dev, struct seq_file *seq)
> +{
> +	unsigned char val;
> +
> +	val = M48T59_READ(M48T59_FLAGS);
> +	seq_printf(seq, "battery\t\t: %s\n",
> +		 (val & M48T59_FLAGS_BF) ? "low" : "normal");
> +
> +	return 0;
> +}

 this is going to be deprecated, you can use it but it will fade away
 sooner or later. you might want to add a sysfs attribute
 with the battery info.

 thanks.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
