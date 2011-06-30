Return-Path: <meador_inge@mentor.com>
Message-ID: <4E0BE7B4.1020901@mentor.com>
Date: Wed, 29 Jun 2011 22:04:20 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [openmcapi-dev] Re: [PATCH v3 2/2] powerpc: add support for MPIC
	message register API
References: <1306869543-18812-1-git-send-email-meador_inge@mentor.com>	
	<1306869543-18812-3-git-send-email-meador_inge@mentor.com>
	<1308288784.32158.30.camel@pasglop>
In-Reply-To: <1308288784.32158.30.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: openmcapi-dev@googlegroups.com,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2011 12:33 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2011-05-31 at 14:19 -0500, Meador Inge wrote:
>> Some MPIC implementations contain one or more blocks of message registers
>> that are used to send messages between cores via IPIs.  A simple API has
>> been added to access (get/put, read, write, etc ...) these message registers.
>> The available message registers are initially discovered via nodes in the
>> device tree.  A separate commit contains a binding for the message register
>> nodes.

<snip>

> 
> Ok, so we have another scheme of:
> 
>  - Count all devices in the system of a given type
>  - Assign them numbers
>  - API uses number
> 
> That sucks... unless you have an allocator. And even then.
> 
> I'd rather clients use something like struct mpic_msgr (or msg_reg or
> message_reg) as the "handle" to one of these things.
> 
> It can be obtained via an allocator or a device tree parsing routine if
> there's a fixed relationship between clients and registers, I don't
> really know how that stuff is to be used, but in any case, the whole
> thing stinks as it is.

Ben,

I posted a more detailed response a few days back:
http://patchwork.ozlabs.org/patch/98075/.  In
that response, I tried to put forth the rationale
for allocating the registers statically due to
the AMP use case.  With that in mind, do you
still disagree with the design?  If so, do
you have any suggestions for how it could be
better?

-- 
Meador Inge
CodeSourcery / Mentor Embedded
http://www.mentor.com/embedded-software
