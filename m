Subject: Re: [PATCH][RFC] have_residual_data()
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1290.81.137.83.225.1086682323.squirrel@www.solinno.co.uk>
References: <1290.81.137.83.225.1086682323.squirrel@www.solinno.co.uk>
Content-Type: text/plain
Message-Id: <1086809994.3227.83.camel@localhost>
Mime-Version: 1.0
Date: Wed, 09 Jun 2004 14:39:54 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-06-08 at 03:12, Leigh Brown wrote:

> I just read Gustavo's email, and co-incidently have finally began looking
> again at my patches over the last couple of days to see about making
> them good enough to submit.  To this end, please find attached a patch
> to create a new inline function have_residual_data(), which looks like
> this:
>
> static inline int have_residual_data(void) {
> #if       defined(CONFIG_PREP_RESIDUAL)
> 	return res && res->ResidualLength;
> #else /* !defined(CONFIG_PREP_RESIDUAL) */
> 	return 0;
> #endif /* defined(CONFIG_PREP_RESIDUAL) */
> }

Sounds like a great idea. :) Without having time to read the whole
patch, I think preferred style is:

#if       defined(CONFIG_PREP_RESIDUAL)
static inline int have_residual_data(void) {
	return res && res->ResidualLength;
}
#else /* !defined(CONFIG_PREP_RESIDUAL) */
static inline int have_residual_data(void) {
	return 0;
}
#endif /* defined(CONFIG_PREP_RESIDUAL) */

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
