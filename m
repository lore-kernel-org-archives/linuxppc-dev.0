Return-Path: <mikey@neuling.org>
Message-ID: <1400022263.2665.2.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: relocate "config DTL" so KConfig nests
 properly
From: Michael Neuling <mikey@neuling.org>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Wed, 14 May 2014 09:04:23 +1000
In-Reply-To: <5371C5E5.6070701@linux.vnet.ibm.com>
References: <1399950599-24826-1-git-send-email-cody@linux.vnet.ibm.com>
 <1399962216.7554.63.camel@ale.ozlabs.ibm.com>
 <5371C5E5.6070701@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Paul Bolle <pebolle@tiscali.nl>, Gavin Shan <shangw@linux.vnet.ibm.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-13 at 00:12 -0700, Cody P Schafer wrote:
> On 05/12/2014 11:23 PM, Michael Neuling wrote:
> >> powerpc/pseries: relocate "config DTL" so KConfig nests properly
> >
> > I don't know what that means.  Can you describe it in more detail?
> >
>=20
> So the "config DTL" refers to the configuration entry.
>=20
> The "nests properly" refers to the indent that 'make menuconfig' shows=
=20
> when a config-option that depends on the config-option proceeding it.
>=20
> In this case, moving config DTL up so it is below config PPC_SPLPAR=20
> means that menuconfig will show config DTL nicely indented right below=
=20
> config PPC_SPLPAR when PPC_SPLPAR is enabled.
>=20
> To contrast that, right now if I enable PPC_SPLPAR in menuconfig, all I=
=20
> can immediately tell is that "something showed up further down the list=
=20
> where I wasn't looking", and I end up having to toggle the option a few=
=20
> times to figure out what showed up, or look at the KConfig to find out=
=20
> that config DTL depends on config PPC_SPLPAR.
>=20
> Essentially, this enables menuconfig to provide a visual hint about the=
=20
> dependencies between options.

Sounds like a good idea.  Can you repost the patch with that same info
in the commit log.

Mikey


> > Mikey
> >
> >
> > On Mon, 2014-05-12 at 20:09 -0700, Cody P Schafer wrote:
> >> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> >> ---
> >>   arch/powerpc/platforms/pseries/Kconfig | 20 ++++++++++----------
> >>   1 file changed, 10 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/pla=
tforms/pseries/Kconfig
> >> index 2cb8b77..e00dd4d 100644
> >> --- a/arch/powerpc/platforms/pseries/Kconfig
> >> +++ b/arch/powerpc/platforms/pseries/Kconfig
> >> @@ -33,6 +33,16 @@ config PPC_SPLPAR
> >>   	  processors, that is, which share physical processors between
> >>   	  two or more partitions.
> >>
> >> +config DTL
> >> +	bool "Dispatch Trace Log"
> >> +	depends on PPC_SPLPAR && DEBUG_FS
> >> +	help
> >> +	  SPLPAR machines can log hypervisor preempt & dispatch events to a
> >> +	  kernel buffer. Saying Y here will enable logging these events,
> >> +	  which are accessible through a debugfs file.
> >> +
> >> +	  Say N if you are unsure.
> >> +
> >>   config PSERIES_MSI
> >>          bool
> >>          depends on PCI_MSI && PPC_PSERIES && EEH
> >> @@ -122,13 +132,3 @@ config HV_PERF_CTRS
> >>   	  systems. 24x7 is available on Power 8 systems.
> >>
> >>             If unsure, select Y.
> >> -
> >> -config DTL
> >> -	bool "Dispatch Trace Log"
> >> -	depends on PPC_SPLPAR && DEBUG_FS
> >> -	help
> >> -	  SPLPAR machines can log hypervisor preempt & dispatch events to a
> >> -	  kernel buffer. Saying Y here will enable logging these events,
> >> -	  which are accessible through a debugfs file.
> >> -
> >> -	  Say N if you are unsure.
> >
>=20
