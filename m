Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18586.14112.751080.325656@cargo.ozlabs.ibm.com>
Date: Thu, 7 Aug 2008 09:43:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: Remove bogons from the iSeries console
In-Reply-To: <20080806140629.268fcf07@lxorguk.ukuu.org.uk>
References: <20080806140629.268fcf07@lxorguk.ukuu.org.uk>
Cc: boutcher@us.ibm.com, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	devilbis@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Cox writes:

> --- a/drivers/char/viocons.c
> +++ b/drivers/char/viocons.c
> @@ -705,10 +705,6 @@ static int viotty_ioctl(struct tty_struct *tty, struct file *file,
>  	case KDSKBLED:
>  		return 0;
>  	}
> -	/* FIXME: WTF is this being called for ??? */
> -	lock_kernel();
> -	ret =  n_tty_ioctl(tty, file, cmd, arg);
> -	unlock_kernel();
>  	return ret;
>  }

I think you want "return -ENOIOCTLCMD" rather than "return ret" since
ret is uninitialized with your patch applied.  I agree the call to
n_tty_ioctl is bogus but I think we just want to return -ENOIOCTLCMD.

Paul.
