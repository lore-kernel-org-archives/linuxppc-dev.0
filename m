Return-Path: <Hollis_Blanchard@mentor.com>
Message-ID: <4DBAED5D.4060906@mentor.com>
Date: Fri, 29 Apr 2011 09:54:53 -0700
From: Hollis Blanchard <hollis_blanchard@mentor.com>
MIME-Version: 1.0
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: Re: [PATCH 2/2] powerpc: add support for MPIC message register API
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>
	<1303232375-25014-3-git-send-email-meador_inge@mentor.com>
	<071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Meador Inge <meador_inge@mentor.com>,
	"openmcapi-dev@googlegroups.com" <openmcapi-dev@googlegroups.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2011 10:00 PM, Kushwaha Prabhakar-B32579 wrote:
> Hi,
>
> I have no comments about coding and architecture. It looks fine.
>
> Only have a query about its use case..
>    "Any application intended to use message interrupt requires to know reg_num because of struct mpic_msgr* mpic_msgr_get(unsigned int reg_num) API"
>
> It will be good to search available unit internally and provide its pointer. It will make application more flexible.
>

The problem is that you fundamentally cannot implement an allocator for 
MSG registers if you're going to communicate with another kernel (how 
would both kernels' allocators be synchronized?). So the message 
register allocation must be decided at design time, not run time.

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
