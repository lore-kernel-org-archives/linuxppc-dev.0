Return-Path: <meador_inge@mentor.com>
Message-ID: <4D4F4BAD.4000909@mentor.com>
Date: Sun, 06 Feb 2011 19:32:29 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 1/4] powerpc: Removing support for 'protected-sources'
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>	
	<1296861941-3370-2-git-send-email-meador_inge@mentor.com>
	<1297035336.14982.14.camel@pasglop>
In-Reply-To: <1297035336.14982.14.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/06/2011 05:35 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2011-02-04 at 17:25 -0600, Meador Inge wrote:
>> In a recent thread [1,2,3] concerning device trees for AMP systems, the
>> question of whether we really need 'protected-sources' arose.  The general
>> consensus was that a new boolean property 'pic-no-reset' (described in more
>> detail in a following patch) could be expanded to cover the use cases that
>> 'protected-sources' was covering.
>>
>> One concern that was raised was for legacy systems which already use the
>> 'protected-sources' property [4].  For legacy use cases, 'protected-sources'
>> will be treated as an alias of 'pic-no-reset'.  The sources
>> encoded in the 'protected-sources' cells, however, will not be processed.  This
>> legacy check is added in a later patch in the series.
>
> I'm a bit annoyed here. Why do we need to do that ? Those Cell machines

Apologies, that certainly was not the intent.

> are going to be real bastards to find and test with, and I don't really
> see the point...

The idea came up when submitting a patch for documenting an Open PIC 
binding.  The following two properties were documented in that binding: 
(1) "protected-sources" and (2) "pic-no-reset".  "pic-no-reset" is a 
newly proposed property with the intent of specifying from a device tree 
that the PIC should not be reset.  The question of whether the one 
property, "pic-no-reset", would suffice for both purposes came up.

It seems reasonable that "pic-no-reset" could satisfy the use case that 
"protected-sources" is covering (since all of the sources that a 
particular machine is actually using are already explicitly mentioned in 
the device tree) and the use case of marking from a device tree that the 
PIC should not be reset.  So it is not so much as a need as it is a 
potential simplification.  It sounds like as a practical concern 
(several systems using "protected-sources" are already in the wild and 
testing considerations) that this may not be possible, which is fine.

> The reason for not resetting the MPIC wasn't -only- about the protected
> sources, but also because, from memory, some MPIC implementations had
> issues when toggling the reset lines (pseries I think is one).
>
> That's actually why the MPIC_WANTS_RESET flag is working the other way
> around, only platforms that actually want the reset set it.
>
> This is orthogonal to the need to touch or not touch the interrupt
> sources as set by firmware. Yes, having protected sources probably
> implies no-reset but the reverse isn't necessarily true.

So barring the removal of protected sources, does the inclusion of the 
"pic-no-reset" property seem reasonable?

> Ben.

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
