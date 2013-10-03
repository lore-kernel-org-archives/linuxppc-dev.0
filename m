Return-Path: <eli@dev.mellanox.co.il>
Received: from mail-ee0-f48.google.com (mail-ee0-f48.google.com [74.125.83.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2AD162C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 17:14:39 +1000 (EST)
Received: by mail-ee0-f48.google.com with SMTP id l10so874811eei.21
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Oct 2013 00:14:36 -0700 (PDT)
Date: Thu, 3 Oct 2013 10:14:33 +0300
From: Eli Cohen <eli@dev.mellanox.co.il>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 50/77] mlx5: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131003071433.GA7299@mtldesk30>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9650a7dfbcfd5f1da21f7b093665abf4b1041071.1380703263.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9650a7dfbcfd5f1da21f7b093665abf4b1041071.1380703263.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 02, 2013 at 12:49:06PM +0200, Alexander Gordeev wrote:
>  
> +	err = pci_msix_table_size(dev->pdev);
> +	if (err < 0)
> +		return err;
> +
>  	nvec = dev->caps.num_ports * num_online_cpus() + MLX5_EQ_VEC_COMP_BASE;
>  	nvec = min_t(int, nvec, num_eqs);
> +	nvec = min_t(int, nvec, err);
>  	if (nvec <= MLX5_EQ_VEC_COMP_BASE)
>  		return -ENOSPC;

Making sure we don't request more vectors then the device's is capable
of -- looks good.
>  
> @@ -131,20 +136,15 @@ static int mlx5_enable_msix(struct mlx5_core_dev *dev)
>  	for (i = 0; i < nvec; i++)
>  		table->msix_arr[i].entry = i;
>  
> -retry:
> -	table->num_comp_vectors = nvec - MLX5_EQ_VEC_COMP_BASE;
>  	err = pci_enable_msix(dev->pdev, table->msix_arr, nvec);
> -	if (err <= 0) {
> +	if (err) {
> +		kfree(table->msix_arr);
>  		return err;
> -	} else if (err > MLX5_EQ_VEC_COMP_BASE) {
> -		nvec = err;
> -		goto retry;
>  	}
>  

According to latest sources, pci_enable_msix() may still fail so why
do you want to remove this code?

> -	mlx5_core_dbg(dev, "received %d MSI vectors out of %d requested\n", err, nvec);
> -	kfree(table->msix_arr);
> +	table->num_comp_vectors = nvec - MLX5_EQ_VEC_COMP_BASE;
>  
> -	return -ENOSPC;
> +	return 0;
>  }
>  
>  static void mlx5_disable_msix(struct mlx5_core_dev *dev)
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
