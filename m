Return-Path: <gavin.hu.2010@gmail.com>
MIME-Version: 1.0
In-Reply-To: <52CA3ED7.2020407@gmail.com>
References: <CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com>
 <52C0D251.2000400@gmail.com>
 <CABiPGEcHxgmuLMcMN1ByutJC22RJPHSZf3n5gF9BgenbfQTJvA@mail.gmail.com>
 <52CA3ED7.2020407@gmail.com>
Date: Mon, 6 Jan 2014 13:51:28 +0800
Message-ID: <CABiPGEcWG22g8vAM3F4RcwZ8HR6ux4-xM_MsKg48x+zqDCYnAA@mail.gmail.com>
Subject: Re: [question] Can the execution of the atomtic operation instruction
 pair lwarx/stwcx be interrrupted by local HW interruptions?
From: Gavin Hu <gavin.hu.2010@gmail.com>
To: wyang <w90p710@gmail.com>
Content-Type: multipart/alternative; boundary=089e01182bbedd823204ef46d9c3
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e01182bbedd823204ef46d9c3
Content-Type: text/plain; charset=ISO-8859-1

Get it. Thanks!  :)


BR
Gavin. Hu


On Mon, Jan 6, 2014 at 1:27 PM, wyang <w90p710@gmail.com> wrote:

>
> On 01/06/2014 11:41 AM, Gavin Hu wrote:
>
>  Thanks your response.  :)
> But that means that these optimitive operations like atomic_add() aren't
> optimitive actully in PPC architecture, right? Becuase they can be
> interrupted by loacl HW interrupts. Theoretically, the ISR also can access
> the atomic gloable variable.
>
>
> Nope, my understand is that if you wanna sync kernel primitive code with
> ISR, you have responsibility to disable local interrupts. atomic_add does
> not guarantee to handle such case.
>
> Thanks
> Wei
>
>
>
>
> The following codes are complete atomic_inc() copied from arch/
> static __inline__ void atomic_add(int a, atomic_t *v)
> {
>     int t;
>
>     __asm__ __volatile__(
> "1:    lwarx    %0,0,%3        # atomic_add\n\
>     add    %0,%2,%0\n"
>     PPC405_ERR77(0,%3)
> "    stwcx.    %0,0,%3 \n\
>     bne-    1b"
>     : "=&r" (t), "+m" (v->counter)
>     : "r" (a), "r" (&v->counter)
>     : "cc");
> }
>
>
>  BR
>  Gavin. Hu
>
>
> On Mon, Dec 30, 2013 at 9:54 AM, wyang <w90p710@gmail.com> wrote:
>
>>  On 12/28/2013 01:41 PM, Gavin Hu wrote:
>>
>> Hi
>>
>> I notice that there is a pair ppc instructions lwarx and stwcx used to
>> atomtic operation for instance, atomic_inc/atomic_dec.
>>
>>  In some ppc manuals, they more emphasize its mechanism is that lwarx
>> can reseve the target memory address preventing other CORE from modifying
>> it.
>>
>>  I assume that there is atomtic operation executing on the CORE0 in a
>> multicore system. In this situation, does the CORE0 disable the local HW
>> interrupt?
>>  Can the executing process from the beginning of lwarx and end of stwcx
>> be interrupted by HW interruptions/exceptions?  Anyway, they are two
>> assembly instructions.
>>
>>
>>  It should just like other arch, the processor should response any
>> interrupt after the execution of a instruction, so the local HW interrupt
>> is not disabled.
>>
>> Thanks
>> Wei
>>
>>
>>  Thanks a lot!
>>
>> "1:    lwarx    %0,0,%2        # atomic_inc\n\
>>     addic    %0,%0,1\n"
>> "    stwcx.    %0,0,%2 \n\
>>
>>
>>  BR
>>  Gavin. Hu
>>
>>
>>  _______________________________________________
>> Linuxppc-dev mailing listLinuxppc-dev@lists.ozlabs.orghttps://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>
>>
>
>

--089e01182bbedd823204ef46d9c3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Get it. Thanks!=A0 :)<br><br><br></div>BR<br></d=
iv>Gavin. Hu<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmai=
l_quote">On Mon, Jan 6, 2014 at 1:27 PM, wyang <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:w90p710@gmail.com" target=3D"_blank">w90p710@gmail.com</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><div class=3D"im">
    <br>
    <div>On 01/06/2014 11:41 AM, Gavin Hu wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>Thanks your response.=A0 :) <br>
            But that means that these optimitive operations like
            atomic_add() aren&#39;t optimitive actully in PPC architecture,
            right? Becuase they can be interrupted by loacl HW
            interrupts. Theoretically, the ISR also can access the
            atomic gloable variable.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br></div>
    Nope, my understand is that if you wanna sync kernel primitive code
    with ISR, you have responsibility to disable local interrupts.
    atomic_add does not guarantee to handle such case.<br>
    <br>
    Thanks<br>
    Wei<div><div class=3D"h5"><br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>
            <br>
            <br>
            The following codes are complete atomic_inc() copied from
            arch/<br>
            static __inline__ void atomic_add(int a, atomic_t *v)<br>
            {<br>
            =A0=A0=A0 int t;<br>
            <br>
            =A0=A0=A0 __asm__ __volatile__(<br>
            &quot;1:=A0=A0=A0 lwarx=A0=A0=A0 %0,0,%3=A0=A0=A0 =A0=A0=A0 # a=
tomic_add\n\<br>
            =A0=A0=A0 add=A0=A0=A0 %0,%2,%0\n&quot;<br>
            =A0=A0=A0 PPC405_ERR77(0,%3)<br>
            &quot;=A0=A0=A0 stwcx.=A0=A0=A0 %0,0,%3 \n\<br>
            =A0=A0=A0 bne-=A0=A0=A0 1b&quot;<br>
            =A0=A0=A0 : &quot;=3D&amp;r&quot; (t), &quot;+m&quot; (v-&gt;co=
unter)<br>
            =A0=A0=A0 : &quot;r&quot; (a), &quot;r&quot; (&amp;v-&gt;counte=
r)<br>
            =A0=A0=A0 : &quot;cc&quot;);<br>
            }<br>
            <br>
            <br>
          </div>
          BR<br>
        </div>
        Gavin. Hu<br>
      </div>
      <div class=3D"gmail_extra"><br>
        <br>
        <div class=3D"gmail_quote">On Mon, Dec 30, 2013 at 9:54 AM, wyang
          <span dir=3D"ltr">&lt;<a href=3D"mailto:w90p710@gmail.com" target=
=3D"_blank">w90p710@gmail.com</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
            <div text=3D"#000000" bgcolor=3D"#FFFFFF">
              <div>
                <div>On 12/28/2013 01:41 PM, Gavin Hu wrote:<br>
                </div>
                <blockquote type=3D"cite">
                  <div dir=3D"ltr">Hi <br>
                    <div><br>
                      I notice that there is a pair ppc instructions
                      lwarx and stwcx used to atomtic operation for
                      instance, atomic_inc/atomic_dec.<br>
                      <br>
                    </div>
                    <div>In some ppc manuals, they more emphasize its
                      mechanism is that lwarx can reseve the target
                      memory address preventing other CORE from
                      modifying it.<br>
                      <br>
                    </div>
                    <div>I assume that there is atomtic operation
                      executing on the CORE0 in a multicore system. In
                      this situation, does the CORE0 disable the local
                      HW interrupt?<br>
                    </div>
                    <div>Can the executing process from the beginning of
                      lwarx and end of stwcx be interrupted by HW
                      interruptions/exceptions?=A0 Anyway, they are two
                      assembly instructions.<br>
                    </div>
                  </div>
                </blockquote>
                <br>
              </div>
              It should just like other arch, the processor should
              response any interrupt after the execution of a
              instruction, so the local HW interrupt is not disabled.<br>
              <br>
              Thanks<br>
              Wei<br>
              <blockquote type=3D"cite">
                <div>
                  <div dir=3D"ltr">
                    <div> <br>
                      =A0Thanks a lot!<br>
                    </div>
                    <div><br>
                      &quot;1:=A0=A0=A0 lwarx=A0=A0=A0 %0,0,%2=A0=A0=A0 =A0=
=A0=A0 # atomic_inc\n\<br>
                      =A0=A0=A0 addic=A0=A0=A0 %0,%0,1\n&quot;<br>
                      &quot;=A0=A0=A0 stwcx.=A0=A0=A0 %0,0,%2 \n\<br>
                      <br>
                      <br>
                    </div>
                    <div>BR<br>
                    </div>
                    <div>Gavin. Hu<br>
                    </div>
                  </div>
                  <br>
                  <fieldset></fieldset>
                  <br>
                </div>
                <pre>_______________________________________________
Linuxppc-dev mailing list
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxppc=
-dev@lists.ozlabs.org</a>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
              </blockquote>
              <br>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </div></div></div>

</blockquote></div><br></div>

--089e01182bbedd823204ef46d9c3--
