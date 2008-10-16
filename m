Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18678.56148.594655.885760@cargo.ozlabs.ibm.com>
Date: Thu, 16 Oct 2008 17:12:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH/RFC] 64 bit csum_partial_copy_generic
In-Reply-To: <48EF9C71.9000009@austin.ibm.com>
References: <alpine.LFD.1.10.0809101502580.14991@localhost.localdomain>
	<18670.62070.659790.67023@drongo.ozlabs.ibm.com>
	<48EF9C71.9000009@austin.ibm.com>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org, fulkgl@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joel Schopp writes:

> As for the technical comments, I agree with all of them and will 
> incorporate them into the next version.

Mark Nelson is working on new memcpy and __copy_tofrom_user routines
that look like they will be simpler than the old ones as well as being
faster, particularly on Cell.  It turns out that doing unaligned
8-byte loads is faster than doing aligned loads + shifts + ors on
POWER5 and later machines.  So I suggest that you try a loop that does
say 4 ld's and 4 std's rather than worrying with all the complexity of
the shifts and ors.  On POWER3, ld and std that are not 4-byte aligned
will cause an alignment interrupt, so there I suggest we fall back to
just using lwz and stw as at present (though maybe with the loop
unrolled a bit more).  We'll be adding a feature bit to tell whether
the cpu can do unaligned 8-bytes loads and stores without trapping.

Paul.
