Return-Path: <michael@ellerman.id.au>
Message-ID: <1378778772.25578.1.camel@concordia>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 10 Sep 2013 12:06:12 +1000
In-Reply-To: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 eranian@google.com, acme@redhat.com, linuxppc-dev@ozlabs.org,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-30 at 09:54 +0530, Anshuman Khandual wrote:
> 	This patchset is the re-spin of the original branch stack sampling
> patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
> also enables SW based branch filtering support for PPC64 platforms which have
> branch stack sampling support. With this new enablement, the branch filter support
> for PPC64 platforms have been extended to include all these combinations discussed
> below with a sample test application program.

...

> Mixed filters
> -------------
> (6) perf record -e branch-misses:u -j any_call,any_ret ./cprog
> Error:
> The perf.data file has no samples!
> 
> NOTE: As expected. The HW filters all the branches which are calls and SW tries to find return
> branches in that given set. Both the filters are mutually exclussive, so obviously no samples
> found in the end profile.

The semantics of multiple filters is not clear to me. It could be an OR,
or an AND. You have implemented AND, does that match existing behaviour
on x86 for example?

cheers
