Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C1F1BDDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 06:12:04 +1100 (EST)
Date: Tue, 23 Dec 2008 22:12:02 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] powerpc/iseries: Kexec is known not to work on iseries
Message-ID: <20081223191202.GA18436@oksana.dev.rtsoft.ru>
References: <102d4cdd8493017c104fda0dccc513bce056430c.1230024187.git.michael@ellerman.id.au>
	<20081223185051.GX6958@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081223185051.GX6958@localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nathan,

On Tue, Dec 23, 2008 at 12:50:51PM -0600, Nathan Lynch wrote:
> Hi,
> 
> Michael Ellerman wrote:
> > The non-zero return from the prepare callback is returned by sys_kexec_load()
> > to userspace, indicating that kexec is not supported on the machine.
> 
> ...
> 
> > @@ -638,6 +639,13 @@ static int __init iseries_probe(void)
> >  	return 1;
> >  }
> >  
> > +#ifdef CONFIG_KEXEC
> > +static int iseries_kexec_prepare(struct kimage *image)
> > +{
> > +	return -ENOSYS;
> > +}
> > +#endif
> > +
> >  define_machine(iseries) {
> >  	.name			= "iSeries",
> >  	.setup_arch		= iSeries_setup_arch,
> > @@ -658,6 +666,9 @@ define_machine(iseries) {
> >  	.probe			= iseries_probe,
> >  	.ioremap		= iseries_ioremap,
> >  	.iounmap		= iseries_iounmap,
> > +#ifdef CONFIG_KEXEC
> > +	.machine_kexec_prepare	= iseries_kexec_prepare,
> > +#endif
> >  	/* XXX Implement enable_pmcs for iSeries */
> >  };
> 
> But machine_kexec_prepare() already returns -ENOSYS if the platform
> doesn't have the hook in ppc_md. I must be missing something;

Yeah, the kexec discussion, starting from here:
http://ozlabs.org/pipermail/linuxppc-dev/2008-December/066321.html

The default behaviour has changed.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
