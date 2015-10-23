Return-Path: <mpe@ellerman.id.au>
Message-ID: <1445565296.27586.3.camel@ellerman.id.au>
Subject: Re: Time to remove platforms/cell?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geoff Levand <geoff@infradead.org>, Marc Dietrich <marvin24@gmx.de>,
 Declan Malone <declan.malone@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 23 Oct 2015 12:54:56 +1100
In-Reply-To: <1445541315.30908.148.camel@infradead.org>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <1444327832.29301.27.camel@infradead.org>
 <1444412742.29301.90.camel@infradead.org> <2993505.617vsrhBxj@fb07-iapwap2>
 <1445541315.30908.148.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-22 at 12:15 -0700, Geoff Levand wrote:

> Hi,
> 
> On Fri, 2015-10-09 at 23:13 +0200, Marc Dietrich wrote:

> > Am Freitag, 9. Oktober 2015, 10:45:42 schrieb Geoff Levand:

> > > With the 4.2-rc4 kernel, kexec seems to work when CONFIG_SPU_FS=n. 
> > >  I
> > > have not tried with petitboot release white-09.09.01-15.56 yet though.
> > 
> > I guess you mean 4.3-rc4. Still no luck with CONFIG_SPU_FS=n. No output even 
> > with direct calling kexec. Can you put a working kernel/initrd to some place 
> > so I can try this?
> 
> I did some more work on this, but still did not find out what the problem
> is.  Kexec from 4.3 -> 4.3 works, but with the white-09.09.01-15.56
> petitboot (2.6.30.9) -> 4.3 gets a kernel panic:
> 
>  -> early_setup(), dt_ptr: 0x7fff000
> Kernel panic - not syncing: BUG: Failed verifying flat device tree, bad version?
> 
> I'll look at it some more as I find time.

That says that the device tree firmware gave you (ie. from kexec), is using an
old version of the device tree format.

I can't remember off the top of my head which version you need, but basically
newer kernels require a newer device tree format. So your kexec might be too
old?

cheers
