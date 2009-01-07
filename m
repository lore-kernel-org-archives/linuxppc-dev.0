Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by ozlabs.org (Postfix) with ESMTP id 3C6C5DE276
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 03:07:02 +1100 (EST)
Received: by gxk9 with SMTP id 9so2750959gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 08:07:01 -0800 (PST)
Message-ID: <fa686aa40901070807i8b91856y34a079c9e0835149@mail.gmail.com>
Date: Wed, 7 Jan 2009 09:07:00 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 1/5] powerpc: Add platform support for AmigaOne
In-Reply-To: <20090107135457.234150@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107135457.234150@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 6:54 AM, Gerhard Pircher <gerhard_pircher@gmx.net> wrote:
> +
> +void amigaone_show_cpuinfo(struct seq_file *m)
> +{
> +       struct device_node *root;
> +       const char *model = "";
> +
> +       root = of_find_node_by_path("/");
> +       if (root)
> +               model = of_get_property(root, "model", NULL);
> +       seq_printf(m, "machine\t\t: %s\n", model);
> +
> +       of_node_put(root);
> +       return;
> +}

show_cpuinfo() common code already prints the model.  You can drop this hook.

> +void __init amigaone_setup_arch(void)
> +{
> +       struct device_node *np;
> +
> +       /* Initialization until calibrate_delay() runs. */
> +       loops_per_jiffy = 50000000/HZ;

If it doesn't noticeably slow down the boot then I would remove this line.

Otherwise looks okay to me.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
