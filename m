Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <42541A55.1030606@nortel.com>
References: <42541A55.1030606@nortel.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <5b292a628bb78373928a0e1626086707@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 6 Apr 2005 12:58:53 -0500
To: "Chris Friesen" <cfriesen@nortel.com>
Cc: linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 6, 2005, at 12:20 PM, Chris Friesen wrote:

> Kumar Gala wrote:
>
> > static inline pte_t ptep_get_and_clear(struct mm_struct *mm, =
unsigned
>  > long addr,
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pte_t *ptep)
>  > {
>  >=A0=A0=A0=A0=A0=A0=A0=A0 pte_t tmp =3D *ptep;
>  >=A0=A0=A0=A0=A0=A0=A0=A0 pte_update(ptep, ~_PAGE_HASHPTE, 0);
>  >=A0=A0=A0=A0=A0=A0=A0=A0 return tmp;
>  > }
>
> Doesn't work.=A0 The update and storing of the old value must be =
atomic.
> The value of the pte can change between storing the tmp value and
> calling pte_update().

Thanks, realized this after a bit more thought, and some discussion on=20=

lkml :)

Guess, I need to write a 64-bit pte version of pte_update, foo!

- kumar
