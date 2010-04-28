Return-Path: <sanjeevfiles@yahoo.com>
Received: from web63006.mail.re1.yahoo.com (web63006.mail.re1.yahoo.com
	[69.147.96.217]) by ozlabs.org (Postfix) with SMTP id 1A42FB7D45
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Apr 2010 18:27:34 +1000 (EST)
Message-ID: <193202.72183.qm@web63006.mail.re1.yahoo.com>
Date: Wed, 28 Apr 2010 01:27:32 -0700 (PDT)
From: Maindoor <sanjeevfiles@yahoo.com>
Subject: change_page_attr support on ppc, patch discussion
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1068691629-1272443252=:72183"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-1068691629-1272443252=:72183
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
I am trying to set a page of my data-structure as read-only on a USI MPC834=
7E.
This is primarily to figure a data structure corruption issue.
Added small support as follows:
ppc/mm/init.c:MMU_setup

=A0=A0=A0 __map_without_bats =3D 1;
=A0=A0=A0 __map_without_ltlbs =3D 1;


ppc/mm/pgtable.c

static int __change_page_attr(struct page *page, pgprot_t prot)
{
=A0=A0=A0 pte_t *kpte;
=A0=A0=A0 pmd_t *kpmd;
=A0=A0=A0 unsigned long address;

=A0=A0=A0 BUG_ON(PageHighMem(page));
=A0=A0=A0 address =3D (unsigned long)page_address(page);

=A0=A0=A0 if (v_mapped_by_bats(address) || v_mapped_by_tlbcam(address))
=A0=A0=A0=A0=A0=A0=A0 return 0;
=A0=A0=A0 if (!get_pteptr(&init_mm, address, &kpte, &kpmd))
=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
=A0=A0=A0 set_pte_at(&init_mm, address, kpte, mk_pte(page, prot));
=A0=A0=A0 wmb();
=A0=A0=A0 flush_HPTE(0, address, pmd_val(*kpmd));
=A0=A0=A0 pte_unmap(kpte);
=A0=A0=A0 mb();
=A0=A0=A0 return 0;
}

/*
=A0* Change the page attributes of an page in the linear mapping.
*/
int change_page_attr(struct page *page, int numpages, pgprot_t prot)
{
=A0=A0=A0 int i, err =3D 0;
=A0=A0=A0 unsigned long flags;

=A0=A0=A0 local_irq_save(flags);
=A0=A0=A0 for (i =3D 0; i < numpages; i++, page++) {
=A0=A0=A0=A0=A0=A0=A0 err =3D __change_page_attr(page, prot);
=A0=A0=A0=A0=A0=A0=A0 if (err)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
=A0=A0=A0 }
=A0=A0=A0 local_irq_restore(flags);
=A0=A0=A0 return err;
}
EXPORT_SYMBOL(change_page_attr);

After allocation of my data structure, when I mark the page readonly like t=
his:
change_page_attr(virt_to_page(dat_str), 1, PAGE_READONLY);

it works (throws Oops) but only for the first time, but subsequent writes
are going through. I expect even the subsequent writes to fail.

One more quirkiness to this is, after changing the page attribute I need to
read the element at least once for this to work.

Have I written the supportive api's (above ) correctly ? This is on 2.6.18 =
kernel.
If there is any other way to catch this corruption please let me know.
kgdb and bdi won't help me as it is a dynamically created data-structure an=
d I
have timing constraints.

Regards,
Maindoor.

=0A=0A=0A      
--0-1068691629-1272443252=:72183
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi,<br>I am trying to set a page of my data-s=
tructure as read-only on a USI MPC8347E.<br>This is primarily to figure a d=
ata structure corruption issue.<br>Added small support as follows:<br>ppc/m=
m/init.c:MMU_setup<br><br>&nbsp;&nbsp;&nbsp; __map_without_bats =3D 1;<br>&=
nbsp;&nbsp;&nbsp; __map_without_ltlbs =3D 1;<br><br><br>ppc/mm/pgtable.c<br=
><br>static int __change_page_attr(struct page *page, pgprot_t prot)<br>{<b=
r>&nbsp;&nbsp;&nbsp; pte_t *kpte;<br>&nbsp;&nbsp;&nbsp; pmd_t *kpmd;<br>&nb=
sp;&nbsp;&nbsp; unsigned long address;<br><br>&nbsp;&nbsp;&nbsp; BUG_ON(Pag=
eHighMem(page));<br>&nbsp;&nbsp;&nbsp; address =3D (unsigned long)page_addr=
ess(page);<br><br>&nbsp;&nbsp;&nbsp; if (v_mapped_by_bats(address) || v_map=
ped_by_tlbcam(address))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>&nbsp;&nbsp;&nbsp; if (!get_pteptr(&amp;init_mm, address, &amp;kpte=
,
 &amp;kpmd))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>&nbsp;&nbsp;&nbsp; set_pte_at(&amp;init_mm, address, kpte, mk_pte(page, =
prot));<br>&nbsp;&nbsp;&nbsp; wmb();<br>&nbsp;&nbsp;&nbsp; flush_HPTE(0, ad=
dress, pmd_val(*kpmd));<br>&nbsp;&nbsp;&nbsp; pte_unmap(kpte);<br>&nbsp;&nb=
sp;&nbsp; mb();<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>/*<br>&nbsp;* C=
hange the page attributes of an page in the linear mapping.<br>*/<br>int ch=
ange_page_attr(struct page *page, int numpages, pgprot_t prot)<br>{<br>&nbs=
p;&nbsp;&nbsp; int i, err =3D 0;<br>&nbsp;&nbsp;&nbsp; unsigned long flags;=
<br><br>&nbsp;&nbsp;&nbsp; local_irq_save(flags);<br>&nbsp;&nbsp;&nbsp; for=
 (i =3D 0; i &lt; numpages; i++, page++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; err =3D __change_page_attr(page, prot);<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp;
 }<br>&nbsp;&nbsp;&nbsp; local_irq_restore(flags);<br>&nbsp;&nbsp;&nbsp; re=
turn err;<br>}<br>EXPORT_SYMBOL(change_page_attr);<br><br>After allocation =
of my data structure, when I mark the page readonly like this:<br>change_pa=
ge_attr(virt_to_page(dat_str), 1, PAGE_READONLY);<br><br>it works (throws O=
ops) but only for the first time, but subsequent writes<br>are going throug=
h. I expect even the subsequent writes to fail.<br><br>One more quirkiness =
to this is, after changing the page attribute I need to<br>read the element=
 at least once for this to work.<br><br>Have I written the supportive api's=
 (above ) correctly ? This is on 2.6.18 kernel.<br>If there is any other wa=
y to catch this corruption please let me know.<br>kgdb and bdi won't help m=
e as it is a dynamically created data-structure and I<br>have timing constr=
aints.<br><br>Regards,<br>Maindoor.<br><br></td></tr></table><br>=0A=0A=0A=
=0A=0A=0A=0A=0A      
--0-1068691629-1272443252=:72183--
