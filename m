Return-Path: <swarren@wwwdotorg.org>
Message-ID: <51AF6C3A.5020609@wwwdotorg.org>
Date: Wed, 05 Jun 2013 10:50:02 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Grant Likely <grant.likely@linaro.org>,
 Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH] dtc: ensure #line directives don't consume data from
 the next line
References: <1370273816-19411-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1370273816-19411-1-git-send-email-swarren@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Marek <mmarek@suse.cz>, jdl@jdl.com,
 Stephen Warren <swarren@nvidia.com>, Ian Campbell <Ian.Campbell@citrix.com>,
 linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2013 09:36 AM, Stephen Warren wrote:
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
> This is a port of upstream dtc commit a1ee6f0 (with same subject) to the
> kernel's copy of dtc.

Rob, Grant, does this look OK to apply for v3.10-rc*?
