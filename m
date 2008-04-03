Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id DCC49DDF2A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 10:03:58 +1100 (EST)
Date: Fri, 4 Apr 2008 10:03:56 +1100
To: Jerone Young <jyoung5@us.ibm.com>
Subject: Re: [PATCH] Add idle wait support for 44x platforms
Message-ID: <20080403230356.GJ20457@bakeyournoodle.com>
References: <7226bef216680748a503.1207262582@thinkpadL>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7226bef216680748a503.1207262582@thinkpadL>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 05:43:02PM -0500, Jerone Young wrote:

Hi Jerone,
	A few minor nits.
> Add idle wait support for 44x platforms
> 
> This patch adds the ability for the CPU to go into wait state while in cpu_idle loop. This helps virtulization solutions know when the guest Linux kernel is in an idle state. There are two ways to do it.
> 
> 1) Command line
> 	idle=spin <-- CPU will spin (this is the default)
> 	idle=wait <-- set CPU into wait state when idle
> 
> 2) The device tree will be checked for the "/hypervisor" node
>    If this node is seen it will use "wait" for idle, so that
>    the hypervisor can know when guest Linux kernel it is in
>    an idle state.
> 
> This patch, unlike the last, isolates the code to 44x platforms.
> 
> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

Can you include a diffstat in here?
 
> +static int current_mode = 0;

Leave this as: static int current_mode;, so it'll end up in the bss

> +int __init ppc44x_idle_init(void)
> +{
> +	if(of_find_node_by_path("/hypervisor") != NULL) {
          ^ space
> +		/* if we find /hypervisor node is in device tree,
> +		   set idle mode to wait */
> +		current_mode = 1; /* wait mode */
> +	}

You don't really need the braces {} here.

> +static int __init idle_param(char *p)
> +{ 
> +	int i;
> +
> +	for (i = 0; i < sizeof(modes)/sizeof(struct sleep_mode); i++) {

ARRAY_SIZE(modes)

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
