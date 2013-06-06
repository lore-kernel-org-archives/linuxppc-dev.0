Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id B7B272C008E
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Jun 2013 09:46:54 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] powerpc,
 perf: Ignore separate BHRB privilege state filter request
In-reply-to: <51B0266F.3090708@linux.vnet.ibm.com>
References: <1369716452-28689-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369716452-28689-2-git-send-email-khandual@linux.vnet.ibm.com>
 <20699.1370494560@ale.ozlabs.ibm.com> <51B0266F.3090708@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Fri, 07 Jun 2013 09:46:54 +1000
Message-ID: <31747.1370562414@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 06/06/2013 10:26 AM, Michael Neuling wrote:
> > Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> >=20
> >> Completely ignore BHRB privilege state filter request as we are
> >> already configuring that with privilege state filtering attribute
> >> for the accompanying PMU event. This would help achieve cleaner
> >> user space interaction for BHRB.
> >>
> >> This patch fixes a situation like this
> >>
> >> Before patch:-
> >> ------------
> >> ./perf record -j any -e branch-misses:k ls
> >> Error:
> >> The sys_perf_event_open() syscall returned with 95 (Operation not supp=
orted) for event (branch-misses:k).
> >> /bin/dmesg may provide additional information.
> >> No CONFIG_PERF_EVENTS=3Dy kernel support configured?
> >>
> >> Here 'perf record' actually copies over ':k' filter request into BHRB
> >> privilege state filter config and our previous check in kernel would
> >> fail that.
> >>
> >> After patch:-
> >> -------------
> >> ./perf record -j any -e branch-misses:k ls
> >> perf  perf.data  perf.data.old  test-mmap-ring
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.002 MB perf.data (~102 samples) ]
> >>
> >> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/perf/power8-pmu.c | 12 ++++--------
> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8=
-pmu.c
> >> index f7d1c4f..3a58416 100644
> >> --- a/arch/powerpc/perf/power8-pmu.c
> >> +++ b/arch/powerpc/perf/power8-pmu.c
> >> @@ -525,16 +525,12 @@ static u64 power8_bhrb_filter_map(u64 branch_sam=
ple_type)
> >>  	u64 pmu_bhrb_filter =3D 0;
> >>  	u64 br_privilege =3D branch_sample_type & ONLY_PLM;
> >>=20=20
> >> -	/* BHRB and regular PMU events share the same prvillege state
> >> +	/* BHRB and regular PMU events share the same privilege state
> >>  	 * filter configuration. BHRB is always recorded along with a
> >> -	 * regular PMU event. So privilege state filter criteria for BHRB
> >> -	 * and the companion PMU events has to be the same. As a default
> >> -	 * "perf record" tool sets all privillege bits ON when no filter
> >> -	 * criteria is provided in the command line. So as along as all
> >> -	 * privillege bits are ON or they are OFF, we are good to go.
> >> +	 * regular PMU event. As the privilege state filter is handled
> >> +	 * in the basic PMC configuration of the accompanying regular
> >> +	 * PMU event, we ignore any separate BHRB specific request.
> >>  	 */
> >> -	if ((br_privilege !=3D 7) && (br_privilege !=3D 0))
> >> -		return -1;
> >=20
> > br_privilege is now unused which causes this compile error.
> >=20
> > arch/powerpc/perf/power8-pmu.c:526:6: error: unused variable =E2=80=98b=
r_privilege=E2=80=99 [-Werror=3Dunused-variable]
> >=20
> > I assume since you didn't compile test this code, you also didn't
> > runtime test it either?!!?!?!?
>=20
>=20
> Always compile with the cross compiler "ARCH=3Dpowerpc
> CROSS_COMPILE=3Dpowerpc64-linux-gnu- make" I copied over
> arch/powerpc/config/pseries_defconfig and compiled it. Some how it
> missed to be a 64 bit kernel config which resulted in shutting down
> compilation of arch/powerpc/perf/power8-pmu.c file. So never
> encountered this compiler warning message before. Will fix this.

I don't understand this at all... pseries_defconfig is a 64bit kernel.

BTW. you don't need to copy it.  Just do "make pseries_defconfig && make
vmlinux".

Mikey
