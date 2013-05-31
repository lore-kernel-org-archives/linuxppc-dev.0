Return-Path: <swarren@wwwdotorg.org>
Message-ID: <51A8E0EE.1040305@wwwdotorg.org>
Date: Fri, 31 May 2013 11:42:06 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] dtc: Ensure #line directives don't consume data from
 the next line
References: <1370020450-18136-1-git-send-email-swarren@wwwdotorg.org>
 <87sj13dp72.fsf@hase.home>
In-Reply-To: <87sj13dp72.fsf@hase.home>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mmarek@suse.cz, jdl@jdl.com, Stephen Warren <swarren@nvidia.com>,
 linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2013 11:38 AM, Andreas Schwab wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> Fix this by replacing {WS} with [ \t] so that it can't match line-breaks.
> 
> I think the other uses of {WS} shouldn't span lines either.

That is true, but only the optional occurrence /should/ matter. Any
changes to the other occurrences would only affect malformed #line
directives, whereas changing this one occurrence would also affect
well-formed #line directives, due to the optional nature of the trailing
flags field.

Still, it may be reasonable just to change all the occurrences anyway.
Does anyone have a strong opinion either way?
