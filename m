Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17993.20745.432703.238649@cargo.ozlabs.ibm.com>
Date: Tue, 15 May 2007 16:19:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] remove build warnings in windfarm_core
In-Reply-To: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
References: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> -	device_create_file(&wf_platform_device.dev, &new_ct->attr);
> +	ret = device_create_file(&wf_platform_device.dev, &new_ct->attr);
> +	if (ret) {
> +		list_del(&new_ct->link);
> +		printk(KERN_WARNING "windfarm: device_creat_file failed"
> +			"for %s\n", new_ct->name);
> +		goto out_unlock;

This shows up why I hate the must_check stuff.  The sysfs files are
not essential for the operation of the windfarm subsystem.  If the
sysfs registration fails for any reason, we now have a completely
non-functional windfarm subsystem instead of a mostly-working one. :(

Paul.
