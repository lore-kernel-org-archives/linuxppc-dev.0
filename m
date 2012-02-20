Return-Path: <paulus@ozlabs.org>
Date: Mon, 20 Feb 2012 11:02:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v7 03/10] fadump: Register for firmware assisted dump.
Message-ID: <20120220000250.GB10186@bloggs.ozlabs.ibm.com>
References: <20120216111050.4733.38034.stgit@mars>
 <20120216111429.4733.24480.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120216111429.4733.24480.stgit@mars>
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>,
 Kexec-ml <kexec@lists.infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Randy Dunlap <rdunlap@xenotime.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 04:44:30PM +0530, Mahesh J Salgaonkar wrote:

> +/*
> + * Prepare for firmware-assisted dump.
> + */
> +int __init setup_fadump(void)
> +{
> +	if (!fw_dump.fadump_supported) {
> +		printk(KERN_ERR "Firmware-assisted dump is not supported on"
> +			" this hardware\n");
> +		return 0;
> +	}
> +
> +	fadump_show_config();
> +	/* Initialize the kernel dump memory structure for FAD registration. */
> +	if (fw_dump.reserve_dump_area_size)
> +		init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
> +	fadump_init_files();
> +
> +	return 1;
> +}
> +subsys_initcall(setup_fadump);

If I have read the code correctly, we are going to get this printk on
non-pSeries machines or on older pSeries machines, even if the user
has not put the fadump=on option on the kernel command line.  The
printk will be annoying since there is no actual error condition.  It
seems to me that the condition for the printk should include
fw_dump.fadump_enabled.  In other words you should probably add

	if (!fw_dump.fadump_enabled)
		return 0;

at the beginning of the function.

Paul.
