Date: Sat, 9 Feb 2002 13:47:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] adjust BAT mapping according to max_low_mem
Message-ID: <20020209204716.GA872@opus.bloom.county>
References: <20020208133604.H25005@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020208133604.H25005@boardwalk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 08, 2002 at 01:36:04PM -0700, Val Henson wrote:

> I'm testing highmem by setting max_low_mem to 64MB and using 256MB RAM
> total (this does not trigger my SCSI bug).  I had to change a few
> things in adjust_total_lowmem to force it to _not_ BAT map of all the
> RAM.  I think the printout of residual is wrong but I'm not sure.

If I'm reading all of the code right, residual at this point should be
(total_lowmem (initial value) - ram mapped in BATs), so I think this:

> +	/* adjust BAT block size to max_low_mem */
> +	if (max_low_mem < bat_max)
> +		bat_max = max_low_mem;
> +
> +	/* adjust lowmem size to max_low_mem */
> +	if (max_low_mem < total_lowmem)
> +		total_lowmem = max_low_mem;
> +
> +	ram = total_lowmem;

Should be:
	/* adjust BAT block size to max_low_mem */
	if (max_low_mem < bat_max)
		bat_max = max_low_mem;

	/* adjust lowmem size to max_low_mem */
	if (max_low_mem < total_lowmem)
		ram = max_low_mem;
	else
		ram = total_lowmem;
	...

	printk(KERN_INFO "Memory BAT mapping: BAT2=%ldMb, BAT3=%ldMb, "
		"residual: %ldMb\n", __bat2 >> 20, __bat3 >> 20,
		(total_lowmem - ram) >> 20);

Does this sound right?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
