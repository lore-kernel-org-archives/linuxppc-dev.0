Return-Path: <heiko.carstens@de.ibm.com>
Date: Wed, 25 Oct 2006 09:52:38 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: arnd@arndb.de
Subject: Re: [PATCH 11/16] sysfs: add support for adding/removing spu sysfs
	attributes
Message-ID: <20061025075238.GA7090@osiris.boeblingen.de.ibm.com>
References: <20061024163113.694643000@arndb.de>
	<20061024163816.460479000@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061024163816.460479000@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +int cpu_add_sysdev_attr(struct sysdev_attribute *attr)
> +{
> +	int cpu;
> +
> +	mutex_lock(&cpu_mutex);
> +
> +	for_each_possible_cpu(cpu) {
> +		sysdev_create_file(get_cpu_sysdev(cpu), attr);
> +	}
> +
> +	mutex_unlock(&cpu_mutex);
> +	return 0;
> +}

You probably should check for errors on sysdev_create_file, clean up and
return an error number instead of always 0.
This is true for all the new functions here.
