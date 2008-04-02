Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] RTAS - adapt procfs interface
Date: Wed, 2 Apr 2008 13:34:35 +0200
References: <200804011512.20834.jens@de.ibm.com>
	<20080401163504.GP7137@localdomain>
	<20080401200404.GS7137@localdomain>
In-Reply-To: <20080401200404.GS7137@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804021334.35331.jens@de.ibm.com>
Cc: maxim@de.ibm.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 01 April 2008, Nathan Lynch wrote:
> Nathan Lynch wrote:
> > 
> > One could argue that the real problem is using the proc_dir_entry's
> > reference count to enforce exclusive open.
> 
> 
> I think this is better... the way these files are used is lame, but
> this should preserve the existing behavior.  I haven't yet tested
> this, can you?

I did and it works for me...

> 
> 
> diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
> index f227659..00bc308 100644
> --- a/arch/powerpc/kernel/rtas_flash.c
> +++ b/arch/powerpc/kernel/rtas_flash.c
> @@ -139,7 +139,7 @@ struct rtas_validate_flash_t
>  	unsigned int update_results;	/* Update results token */
>  };
> 
> -static DEFINE_SPINLOCK(flash_file_open_lock);
> +static atomic_t open_count = ATOMIC_INIT(0);
>  static struct proc_dir_entry *firmware_flash_pde;
>  static struct proc_dir_entry *firmware_update_pde;
>  static struct proc_dir_entry *validate_pde;
> @@ -216,7 +216,7 @@ static int rtas_flash_release(struct inode *inode, struct file *file)
>  		uf->flist = NULL;
>  	}
> 
> -	atomic_dec(&dp->count);
> +	atomic_dec(&open_count);
>  	return 0;
>  }
> 
> @@ -352,26 +352,17 @@ static ssize_t rtas_flash_write(struct file *file, const char __user *buffer,
> 
>  static int rtas_excl_open(struct inode *inode, struct file *file)
>  {
> -	struct proc_dir_entry *dp = PDE(inode);
> -
> -	/* Enforce exclusive open with use count of PDE */
> -	spin_lock(&flash_file_open_lock);
> -	if (atomic_read(&dp->count) > 1) {
> -		spin_unlock(&flash_file_open_lock);
> +	if (atomic_inc_return(&open_count) > 1) {
> +		atomic_dec(&open_count);
>  		return -EBUSY;
>  	}
> 
> -	atomic_inc(&dp->count);
> -	spin_unlock(&flash_file_open_lock);
> -	
>  	return 0;
>  }
> 
>  static int rtas_excl_release(struct inode *inode, struct file *file)
>  {
> -	struct proc_dir_entry *dp = PDE(inode);
> -
> -	atomic_dec(&dp->count);
> +	atomic_dec(&open_count);
> 
>  	return 0;
>  }
> @@ -580,7 +571,7 @@ static int validate_flash_release(struct inode *inode, struct file *file)
>  	}
> 
>  	/* The matching atomic_inc was in rtas_excl_open() */
> -	atomic_dec(&dp->count);
> +	atomic_dec(&open_count);
> 
>  	return 0;
>  }
> 

Gruß,

Jens

IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschäftsführung: Herbert Kircher 
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
