Return-Path: <jdl@jdl.com>
Message-Id: <E1UjUsY-0008Td-Bj@jdl.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2] dtc: ensure #line directives don't consume data from
 the next line
In-reply-to: <1370025184-23808-1-git-send-email-swarren@wwwdotorg.org>
References: <1370025184-23808-1-git-send-email-swarren@wwwdotorg.org>
Date: Mon, 03 Jun 2013 08:32:54 -0500
From: Jon Loeliger <jdl@jdl.com>
Cc: mmarek@suse.cz, Stephen Warren <swarren@nvidia.com>,
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

> From: Stephen Warren <swarren@nvidia.com>
> 
> Previously, the #line parsing regex ended with ({WS}+[0-9]+)?. The {WS}
> could match line-break characters. If the #line directive did not contain
> the optional flags field at the end, this could cause any integer data on
> the next line to be consumed as part of the #line directive parsing. This
> could cause syntax errors (i.e. #line parsing consuming the leading 0
> from a hex literal 0x1234, leaving x1234 to be parsed as cell data,
> which is a syntax error), or invalid compilation results (i.e. simply
> consuming literal 1234 as part of the #line processing, thus removing it
> from the cell data).
> 
> Fix this by replacing {WS} with [ \t] so that it can't match line-breaks.
> 
> Convert all instances of {WS}, even though the other instances should be
> irrelevant for any well-formed #line directive. This is done for
> consistency and ultimate safety.
> 
> Reported-by: Ian Campbell <Ian.Campbell@citrix.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2: Convert all instances of {WS} in the regex.

Applied.

Thanks!

jdl
