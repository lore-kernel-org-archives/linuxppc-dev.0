Return-Path: <michael@ellerman.id.au>
Message-ID: <1380075585.14938.4.camel@concordia>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 25 Sep 2013 12:19:45 +1000
In-Reply-To: <524006C4.3010006@linux.vnet.ibm.com>
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1378778772.25578.1.camel@concordia>
 <CABPqkBREXH5VUkULAsWvmpCer-s4SCxuof6LdqRO0i-iBOG8pA@mail.gmail.com>
 <524006C4.3010006@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-23 at 14:45 +0530, Anshuman Khandual wrote:
> On 09/21/2013 12:25 PM, Stephane Eranian wrote:
> > On Tue, Sep 10, 2013 at 4:06 AM, Michael Ellerman
> > <michael@ellerman.id.au> wrote:
> >> >
> >> > On Fri, 2013-08-30 at 09:54 +0530, Anshuman Khandual wrote:
> >>> > >       This patchset is the re-spin of the original branch stack sampling
> >>> > > patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
> >>> > > also enables SW based branch filtering support for PPC64 platforms which have
> >>> > > branch stack sampling support. With this new enablement, the branch filter support
> >>> > > for PPC64 platforms have been extended to include all these combinations discussed
> >>> > > below with a sample test application program.
> >> >
> >> > ...
> >> >
> >>> > > Mixed filters
> >>> > > -------------
> >>> > > (6) perf record -e branch-misses:u -j any_call,any_ret ./cprog
> >>> > > Error:
> >>> > > The perf.data file has no samples!
> >>> > >
> >>> > > NOTE: As expected. The HW filters all the branches which are calls and SW tries to find return
> >>> > > branches in that given set. Both the filters are mutually exclussive, so obviously no samples
> >>> > > found in the end profile.
> >> >
> >> > The semantics of multiple filters is not clear to me. It could be an OR,
> >> > or an AND. You have implemented AND, does that match existing behaviour
> >> > on x86 for example?
> >
> > The semantic on the API is OR. AND does not make sense: CALL & RETURN?
> > On x86, the HW filter is an OR (default: ALL, set bit to disable a
> > type). I suspect
> > it is similar on PPC.
> 
> Given the situation as explained here, which semantic would be better for single
> HW and multiple SW filters. Accordingly validate_instruction() function will have
> to be re-implemented. But I believe OR-ing the SW filters will be preferable.
> 
> 	(1) (HW_FILTER_1) && (SW_FILTER_1) && (SW_FILTER_2)
> 	or
> 	(2) (HW_FILTER_1) && (SW_FILTER_1 || SW_FILTER_2)
> 
> Please let me know your inputs and suggestions on this. Thank you.

You need to implement the correct semantics, regardless of how the
hardware happens to work.

That means if multiple filters are specified you need to do all the
filtering in software.

cheers
