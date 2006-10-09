Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DA967679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 01:41:31 +1000 (EST)
Date: Mon, 9 Oct 2006 10:40:43 -0500
From: Olof Johansson <olof@lixom.net>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] trivial iomem annotations
	(arch/powerpc/platfroms/parsemi/pci.c)
Message-ID: <20061009104043.0d4c6416@localhost.localdomain>
In-Reply-To: <20061009152309.GQ29920@ftp.linux.org.uk>
References: <20061009152309.GQ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 9 Oct 2006 16:23:09 +0100 Al Viro <viro@ftp.linux.org.uk> wrote:

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Olof Johansson <olof@lixom.net>


> ---
>  arch/powerpc/platforms/pasemi/pci.c |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index 4679c52..39020c1 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -35,17 +35,17 @@ #define PA_PXP_CFA(bus, devfn, off) (((b
>  
>  #define CONFIG_OFFSET_VALID(off) ((off) < 4096)
>  
> -static unsigned long pa_pxp_cfg_addr(struct pci_controller *hose,
> +static void volatile __iomem *pa_pxp_cfg_addr(struct pci_controller *hose,
>  				       u8 bus, u8 devfn, int offset)
>  {
> -	return ((unsigned long)hose->cfg_data) + PA_PXP_CFA(bus, devfn, offset);
> +	return hose->cfg_data + PA_PXP_CFA(bus, devfn, offset);
>  }
>  
>  static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
>  			      int offset, int len, u32 *val)
>  {
>  	struct pci_controller *hose;
> -	unsigned long addr;
> +	void volatile __iomem *addr;
>  
>  	hose = pci_bus_to_host(bus);
>  	if (!hose)
> @@ -62,13 +62,13 @@ static int pa_pxp_read_config(struct pci
>  	 */
>  	switch (len) {
>  	case 1:
> -		*val = in_8((u8 *)addr);
> +		*val = in_8(addr);
>  		break;
>  	case 2:
> -		*val = in_le16((u16 *)addr);
> +		*val = in_le16(addr);
>  		break;
>  	default:
> -		*val = in_le32((u32 *)addr);
> +		*val = in_le32(addr);
>  		break;
>  	}
>  
> @@ -79,7 +79,7 @@ static int pa_pxp_write_config(struct pc
>  			       int offset, int len, u32 val)
>  {
>  	struct pci_controller *hose;
> -	unsigned long addr;
> +	void volatile __iomem *addr;
>  
>  	hose = pci_bus_to_host(bus);
>  	if (!hose)
> @@ -96,16 +96,16 @@ static int pa_pxp_write_config(struct pc
>  	 */
>  	switch (len) {
>  	case 1:
> -		out_8((u8 *)addr, val);
> -		(void) in_8((u8 *)addr);
> +		out_8(addr, val);
> +		(void) in_8(addr);
>  		break;
>  	case 2:
> -		out_le16((u16 *)addr, val);
> -		(void) in_le16((u16 *)addr);
> +		out_le16(addr, val);
> +		(void) in_le16(addr);
>  		break;
>  	default:
> -		out_le32((u32 *)addr, val);
> -		(void) in_le32((u32 *)addr);
> +		out_le32(addr, val);
> +		(void) in_le32(addr);
>  		break;
>  	}
>  	return PCIBIOS_SUCCESSFUL;
