Return-Path: <paulus@ozlabs.org>
Date: Wed, 2 Nov 2016 08:03:01 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 skiboot list <skiboot@lists.ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] cpuidle:powernv: Add helper function to populate
 powernv idle states.
Message-ID: <20161101210301.GA15949@fergus.ozlabs.ibm.com>
References: <cover.1477556602.git.ego@linux.vnet.ibm.com>
 <d7298ac18999f842f6eaf826cf21250503e40890.1477556602.git.ego@linux.vnet.ibm.com>
 <CAOSf1CHZ0_1B28bX9TsaE6vcOaWUwhanQWAN=LKSLoNHK+Jh0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOSf1CHZ0_1B28bX9TsaE6vcOaWUwhanQWAN=LKSLoNHK+Jh0A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 01, 2016 at 07:32:58PM +1100, Oliver O'Halloran wrote:
> On Thu, Oct 27, 2016 at 7:35 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > In the current code for powernv_add_idle_states, there is a lot of code
> > duplication while initializing an idle state in powernv_states table.
> >
> > Add an inline helper function to populate the powernv_states[] table for
> > a given idle state. Invoke this for populating the "Nap", "Fastsleep"
> > and the stop states in powernv_add_idle_states.
> >
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  drivers/cpuidle/cpuidle-powernv.c | 82 +++++++++++++++++++++++----------------
> >  include/linux/cpuidle.h           |  1 +
> >  2 files changed, 49 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> > index 7fe442c..11b22b9 100644
> > --- a/drivers/cpuidle/cpuidle-powernv.c
> > +++ b/drivers/cpuidle/cpuidle-powernv.c
> > @@ -167,6 +167,28 @@ static int powernv_cpuidle_driver_init(void)
> >         return 0;
> >  }
> >
> > +static inline void add_powernv_state(int index, const char *name,
> > +                                    unsigned int flags,
> > +                                    int (*idle_fn)(struct cpuidle_device *,
> > +                                                   struct cpuidle_driver *,
> > +                                                   int),
> > +                                    unsigned int target_residency,
> > +                                    unsigned int exit_latency,
> > +                                    u64 psscr_val)
> > +{
> > +       strncpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
> > +       strncpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
> 
> If the supplied name is equal to CPUIDLE_NAME_LEN then strncpy() won't
> terminate the string. The least annoying fix is to memset() the whole
> structure to zero and set n to CPUIDLE_NAME_LEN - 1.

Or he could use strlcpy() instead of strncpy().

Paul.
