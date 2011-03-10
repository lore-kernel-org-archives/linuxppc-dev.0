Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC650100990
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 04:23:37 +1100 (EST)
References: <1299630721-4337-1-git-send-email-wilsons@start.ca>
	<20110310160032.GA20504@alboin.amr.corp.intel.com>
	<20110310163809.GA20675@alboin.amr.corp.intel.com>
	<20110310165414.GA6431@fibrous.localdomain>
In-Reply-To: <20110310165414.GA6431@fibrous.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----V09616JKR7L2B0NB8391YYHI8HKF8V"
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/5=5D_make_*=5Fgate=5Fvma_accep?=
	=?US-ASCII?Q?t_mm=5Fstruct_instead_of=09task=5Fstruct_II?=
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Thu, 10 Mar 2011 09:22:48 -0800
To: Stephen Wilson <wilsons@start.ca>, Andi Kleen <ak@linux.intel.com>
Message-ID: <37e280c3-7f6b-4f1e-9589-68f4a67e4c0a@email.android.com>
Cc: linux-s390@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org, x86@kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Michel Lespinasse <walken@google.com>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------V09616JKR7L2B0NB8391YYHI8HKF8V
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry... I confused them too. It's TS_COMPAT which is problematic.
-- 
Sent from my mobile phone. Please pardon any lack of formatting.

Stephen Wilson <wilsons@start.ca> wrote:

On Thu, Mar 10, 2011 at 08:38:09AM -0800, Andi Kleen wrote: > On Thu, Mar 10, 2011 at 08:00:32AM -0800, Andi Kleen wrote: > > On Tue, Mar 08, 2011 at 07:31:56PM -0500, Stephen Wilson wrote: > > > The only architecture this change impacts in any significant way is x86_64. > > > The principle change on that architecture is to mirror TIF_IA32 via > > > a new flag in mm_context_t. > > > > The problem is -- you're adding a likely cache miss on mm_struct for > > every 32bit compat syscall now, even if they don't need mm_struct > > currently (and a lot of them do not) Unless there's a very good > > justification to make up for this performance issue elsewhere > > (including numbers) this seems like a bad idea. > > Hmm I see you're only setting it on exec time actually on rereading > the patches. I thought you were changing TS_COMPAT which is in > the syscall path. > > Never mind. I have no problems with doing such a change on exec > time. OK. Great! Does this mean I have your ACK'e!
 d by or
reviewed by? Thanks for taking a look! -- steve 


------V09616JKR7L2B0NB8391YYHI8HKF8V
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body>Sorry... I confused them too.  It&#39;s TS_COMPAT which is problematic.<br>
-- <br>
Sent from my mobile phone.  Please pardon any lack of formatting.<br><br><div class="gmail_quote">Stephen Wilson &lt;wilsons@start.ca&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div style="white-space: pre-wrap; word-wrap:break-word; ">
On Thu, Mar 10, 2011 at 08:38:09AM -0800, Andi Kleen wrote:
&gt; On Thu, Mar 10, 2011 at 08:00:32AM -0800, Andi Kleen wrote:
&gt; &gt; On Tue, Mar 08, 2011 at 07:31:56PM -0500, Stephen Wilson wrote:
&gt; &gt; &gt; The only architecture this change impacts in any significant way is x86_64.
&gt; &gt; &gt; The principle change on that architecture is to mirror TIF_IA32 via
&gt; &gt; &gt; a new flag in mm_context_t. 
&gt; &gt; 
&gt; &gt; The problem is -- you're adding a likely cache miss on mm_struct for
&gt; &gt; every 32bit compat syscall now, even if they don't need mm_struct
&gt; &gt; currently (and a lot of them do not) Unless there's a very good
&gt; &gt; justification to make up for this performance issue elsewhere
&gt; &gt; (including numbers) this seems like a bad idea.
&gt; 
&gt; Hmm I see you're only setting it on exec time actually on rereading
&gt; the patches. I thought you were changing TS_COMPAT which is in
&gt; the syscall path.
&gt; 
&gt; Never mind.  I have no problems with doing such a change on exec
&gt; time.

OK.  Great!  Does this mean I have your ACK'ed by or reviewed by?


Thanks for taking a look!

-- 
steve

</div></blockquote></div></body></html>
------V09616JKR7L2B0NB8391YYHI8HKF8V--
