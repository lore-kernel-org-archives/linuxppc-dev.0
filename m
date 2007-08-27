Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 1C2CEDDF5F
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 10:44:29 +1000 (EST)
Date: Mon, 27 Aug 2007 10:44:28 +1000
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH, RFC] linkstation: implement standby
Message-ID: <20070827004428.GD10345@bakeyournoodle.com>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Aug 26, 2007 at 02:03:49AM +0200, Guennadi Liakhovetski wrote:
> Implement suspend/resume for "mpc10x" compatible fsl host PCI controllers, 
> use it for linkstation standby.

Hi Guennadi

<snip>

> +static int __init ls_pm_init(void)
> +{
> +	if (!machine_is(linkstation))
> +		return 0;

This should probably be -ENODEV.

<snip>

> +int mpc10x_suspend(suspend_state_t state)

You only seem to call this from ls_pm_enter() where you don't check the
return value, perhaps this should be void ?

> +{
> +	struct pci_dev *bridge;
> +	u16 pmcr1;
> +
> +	bridge = pci_find_slot(0, 0);
> +	if (!bridge)
> +		return -ENODEV;

I think you want pci_get_bus_and_slot() here instead of pci_find_slot(),
in fact I think it'd be cleaner, if you located the bridge in
ls_pm_enter() and passed it in.

> +int mpc10x_resume(suspend_state_t state)
> +{
> +	struct pci_dev *bridge;
> +	u16 pmcr1;
> +
> +	bridge = pci_find_slot(0, 0);
> +	if (!bridge)
> +		return -ENODEV;

Same comments ass mpc10x_suspend();

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
