Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF875DE180
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 09:53:12 +1000 (EST)
Date: Thu, 7 Aug 2008 00:35:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]: Remove bogons from the iSeries console
Message-ID: <20080807003526.66bc2c2a@lxorguk.ukuu.org.uk>
In-Reply-To: <18586.14112.751080.325656@cargo.ozlabs.ibm.com>
References: <20080806140629.268fcf07@lxorguk.ukuu.org.uk>
	<18586.14112.751080.325656@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 7 Aug 2008 09:43:28 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Alan Cox writes:
> 
> > --- a/drivers/char/viocons.c
> > +++ b/drivers/char/viocons.c
> > @@ -705,10 +705,6 @@ static int viotty_ioctl(struct tty_struct *tty, struct file *file,
> >  	case KDSKBLED:
> >  		return 0;
> >  	}
> > -	/* FIXME: WTF is this being called for ??? */
> > -	lock_kernel();
> > -	ret =  n_tty_ioctl(tty, file, cmd, arg);
> > -	unlock_kernel();
> >  	return ret;
> >  }
> 
> I think you want "return -ENOIOCTLCMD" rather than "return ret" since
> ret is uninitialized with your patch applied.  I agree the call to
> n_tty_ioctl is bogus but I think we just want to return -ENOIOCTLCMD.

Agreed
