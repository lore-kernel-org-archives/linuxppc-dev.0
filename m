Return-Path: <maynardj@us.ibm.com>
Message-ID: <45BFE2F4.8080309@us.ibm.com>
Date: Tue, 30 Jan 2007 18:29:40 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling
	Cell BE SPUs -- update
References: <45BE4ED0.5030808@us.ibm.com> <45BE4FA4.9020105@us.ibm.com>
	<200701300839.05144.arnd@arndb.de>
	<45BFBB78.7060907@us.ibm.com> <45BFCC8E.4000008@us.ibm.com>
	<1170200044.26655.349.camel@localhost.localdomain>
In-Reply-To: <1170200044.26655.349.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	cbe-oss-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>>I've given this some more thought, and I'm coming to the conclusion that 
>>a pure array-based implementation for holding cached_info (getting rid 
>>of the lists) would work well for the vast majority of cases in which 
>>OProfile will be used.  Yes, it is true that the mapping of an SPU 
>>context to a phsyical spu-numbered array location cannot be guaranteed 
>>to stay valid, and that's why I discard the cached_info at that array 
>>location when the SPU task is switched out.  Yes, it would be terribly 
>>inefficient if the same SPU task gets switched back in later and we 
>>would have to recreate the cached_info.  However, I contend that 
>>OProfile users are interested in profiling one application at a time. 
>>They are not going to want to muddy the waters with multiple SPU apps 
>>running at the same time.  I can't think of any reason why someone would 
>>conscisouly choose to do that.
>>
>>Any thoughts from the general community, especially OProfile users?
> 
> 
> Well, it's my understanding that quite a few typical usage scenario
> involve different tasks running on different SPUs passing each other
> data around.
That shouldn't be a problem.  I would consider this to be "one large 
application" consisting of multiple SPU binaries running simultaneously. 
  Such a scenario can be handled with no negative performance impact 
using a simple 16 element array of cached_info objects -- as long as 
there isn't (much) SPU task switching being done.

-Maynard
> 
> Ben.
> 
> 
