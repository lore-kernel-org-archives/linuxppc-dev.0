Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18724.39197.32453.148515@cargo.ozlabs.ibm.com>
Date: Thu, 20 Nov 2008 09:54:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
In-Reply-To: <20081119170438.GA16240@us.ibm.com>
References: <20081107003841.GE7533@us.ibm.com>
	<18707.53757.132643.518167@cargo.ozlabs.ibm.com>
	<20081117072613.GO16240@us.ibm.com>
	<18723.37096.243151.673526@cargo.ozlabs.ibm.com>
	<20081119170438.GA16240@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sonny Rao writes:

> On Wed, Nov 19, 2008 at 03:07:04PM +1100, Paul Mackerras wrote:
> > I think we should be checking that dev->bsr_len == 4096 here.
> > 
> > Paul.
> 
> Well, dev->bsr_len could be 4096 or 8192

Isn't the dev->bsr_len == 8192 case the one where we'll only map 4096
bytes and therefore not do what the user expected?  Sounds to me like
we want to return an error for that case.

Paul.
