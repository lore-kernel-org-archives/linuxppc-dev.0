Return-Path: <w90p710@gmail.com>
Message-ID: <52CA503A.90905@gmail.com>
Date: Mon, 06 Jan 2014 14:42:02 +0800
From: wyang <w90p710@gmail.com>
MIME-Version: 1.0
To: Gavin Hu <gavin.hu.2010@gmail.com>
Subject: Re: [question] Can the execution of the atomtic operation instruction
 pair lwarx/stwcx be interrrupted by local HW interruptions?
References: <CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com>	<52C0D251.2000400@gmail.com>	<CABiPGEcHxgmuLMcMN1ByutJC22RJPHSZf3n5gF9BgenbfQTJvA@mail.gmail.com>	<52CA3ED7.2020407@gmail.com>
 <CABiPGEeoHCRk_8=yKWnxLAnvh+xg8G-q2r-VbdjtFXudtBS9Hw@mail.gmail.com>
In-Reply-To: <CABiPGEeoHCRk_8=yKWnxLAnvh+xg8G-q2r-VbdjtFXudtBS9Hw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------000600030300080402090605"
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000600030300080402090605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


On 01/06/2014 02:24 PM, Gavin Hu wrote:
> So, these primitive funcitons like atomic_add() and so on also can't 
> prevent processes schedule switch on local CPU core? right?

You are right!

BR
Wei
>
> Thanks!
>
>
> BR
> Gvain. Hu
>
>
> On Mon, Jan 6, 2014 at 1:27 PM, wyang <w90p710@gmail.com 
> <mailto:w90p710@gmail.com>> wrote:
>
>
>     On 01/06/2014 11:41 AM, Gavin Hu wrote:
>>     Thanks your response.  :)
>>     But that means that these optimitive operations like atomic_add()
>>     aren't optimitive actully in PPC architecture, right? Becuase
>>     they can be interrupted by loacl HW interrupts. Theoretically,
>>     the ISR also can access the atomic gloable variable.
>
>     Nope, my understand is that if you wanna sync kernel primitive
>     code with ISR, you have responsibility to disable local
>     interrupts. atomic_add does not guarantee to handle such case.
>
>     Thanks
>     Wei
>
>
>>
>>
>>     The following codes are complete atomic_inc() copied from arch/
>>     static __inline__ void atomic_add(int a, atomic_t *v)
>>     {
>>         int t;
>>
>>         __asm__ __volatile__(
>>     "1:    lwarx    %0,0,%3        # atomic_add\n\
>>         add    %0,%2,%0\n"
>>         PPC405_ERR77(0,%3)
>>     "    stwcx.    %0,0,%3 \n\
>>         bne-    1b"
>>         : "=&r" (t), "+m" (v->counter)
>>         : "r" (a), "r" (&v->counter)
>>         : "cc");
>>     }
>>
>>
>>     BR
>>     Gavin. Hu
>>
>>
>>     On Mon, Dec 30, 2013 at 9:54 AM, wyang <w90p710@gmail.com
>>     <mailto:w90p710@gmail.com>> wrote:
>>
>>         On 12/28/2013 01:41 PM, Gavin Hu wrote:
>>>         Hi
>>>
>>>         I notice that there is a pair ppc instructions lwarx and
>>>         stwcx used to atomtic operation for instance,
>>>         atomic_inc/atomic_dec.
>>>
>>>         In some ppc manuals, they more emphasize its mechanism is
>>>         that lwarx can reseve the target memory address preventing
>>>         other CORE from modifying it.
>>>
>>>         I assume that there is atomtic operation executing on the
>>>         CORE0 in a multicore system. In this situation, does the
>>>         CORE0 disable the local HW interrupt?
>>>         Can the executing process from the beginning of lwarx and
>>>         end of stwcx be interrupted by HW interruptions/exceptions? 
>>>         Anyway, they are two assembly instructions.
>>
>>         It should just like other arch, the processor should response
>>         any interrupt after the execution of a instruction, so the
>>         local HW interrupt is not disabled.
>>
>>         Thanks
>>         Wei
>>>
>>>          Thanks a lot!
>>>
>>>         "1:    lwarx    %0,0,%2        # atomic_inc\n\
>>>             addic    %0,%0,1\n"
>>>         "    stwcx.    %0,0,%2 \n\
>>>
>>>
>>>         BR
>>>         Gavin. Hu
>>>
>>>
>>>         _______________________________________________
>>>         Linuxppc-dev mailing list
>>>         Linuxppc-dev@lists.ozlabs.org  <mailto:Linuxppc-dev@lists.ozlabs.org>
>>>         https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>
>
>


--------------000600030300080402090605
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <div class="moz-cite-prefix">On 01/06/2014 02:24 PM, Gavin Hu wrote:<br>
    </div>
    <blockquote
cite="mid:CABiPGEeoHCRk_8=yKWnxLAnvh+xg8G-q2r-VbdjtFXudtBS9Hw@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div>So, these primitive funcitons like atomic_add() and so on
            also can't prevent processes schedule switch on local CPU
            core? right? <br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    You are right!<br>
    <br>
    BR<br>
    Wei<br>
    <blockquote
cite="mid:CABiPGEeoHCRk_8=yKWnxLAnvh+xg8G-q2r-VbdjtFXudtBS9Hw@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div><br>
            Thanks!<br>
            <br>
            <br>
          </div>
          BR<br>
        </div>
        Gvain. Hu<br>
      </div>
      <div class="gmail_extra"><br>
        <br>
        <div class="gmail_quote">On Mon, Jan 6, 2014 at 1:27 PM, wyang <span
            dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:w90p710@gmail.com" target="_blank">w90p710@gmail.com</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div text="#000000" bgcolor="#FFFFFF">
              <div class="im"> <br>
                <div>On 01/06/2014 11:41 AM, Gavin Hu wrote:<br>
                </div>
                <blockquote type="cite">
                  <div dir="ltr">
                    <div>
                      <div>Thanks your response.&nbsp; :) <br>
                        But that means that these optimitive operations
                        like atomic_add() aren't optimitive actully in
                        PPC architecture, right? Becuase they can be
                        interrupted by loacl HW interrupts.
                        Theoretically, the ISR also can access the
                        atomic gloable variable.<br>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <br>
              </div>
              Nope, my understand is that if you wanna sync kernel
              primitive code with ISR, you have responsibility to
              disable local interrupts. atomic_add does not guarantee to
              handle such case.<br>
              <br>
              Thanks<br>
              Wei
              <div>
                <div class="h5"><br>
                  <br>
                  <blockquote type="cite">
                    <div dir="ltr">
                      <div>
                        <div> <br>
                          <br>
                          The following codes are complete atomic_inc()
                          copied from arch/<br>
                          static __inline__ void atomic_add(int a,
                          atomic_t *v)<br>
                          {<br>
                          &nbsp;&nbsp;&nbsp; int t;<br>
                          <br>
                          &nbsp;&nbsp;&nbsp; __asm__ __volatile__(<br>
                          "1:&nbsp;&nbsp;&nbsp; lwarx&nbsp;&nbsp;&nbsp; %0,0,%3&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; # atomic_add\n\<br>
                          &nbsp;&nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; %0,%2,%0\n"<br>
                          &nbsp;&nbsp;&nbsp; PPC405_ERR77(0,%3)<br>
                          "&nbsp;&nbsp;&nbsp; stwcx.&nbsp;&nbsp;&nbsp; %0,0,%3 \n\<br>
                          &nbsp;&nbsp;&nbsp; bne-&nbsp;&nbsp;&nbsp; 1b"<br>
                          &nbsp;&nbsp;&nbsp; : "=&amp;r" (t), "+m" (v-&gt;counter)<br>
                          &nbsp;&nbsp;&nbsp; : "r" (a), "r" (&amp;v-&gt;counter)<br>
                          &nbsp;&nbsp;&nbsp; : "cc");<br>
                          }<br>
                          <br>
                          <br>
                        </div>
                        BR<br>
                      </div>
                      Gavin. Hu<br>
                    </div>
                    <div class="gmail_extra"><br>
                      <br>
                      <div class="gmail_quote">On Mon, Dec 30, 2013 at
                        9:54 AM, wyang <span dir="ltr">&lt;<a
                            moz-do-not-send="true"
                            href="mailto:w90p710@gmail.com"
                            target="_blank">w90p710@gmail.com</a>&gt;</span>
                        wrote:<br>
                        <blockquote class="gmail_quote" style="margin:0
                          0 0 .8ex;border-left:1px #ccc
                          solid;padding-left:1ex">
                          <div text="#000000" bgcolor="#FFFFFF">
                            <div>
                              <div>On 12/28/2013 01:41 PM, Gavin Hu
                                wrote:<br>
                              </div>
                              <blockquote type="cite">
                                <div dir="ltr">Hi <br>
                                  <div><br>
                                    I notice that there is a pair ppc
                                    instructions lwarx and stwcx used to
                                    atomtic operation for instance,
                                    atomic_inc/atomic_dec.<br>
                                    <br>
                                  </div>
                                  <div>In some ppc manuals, they more
                                    emphasize its mechanism is that
                                    lwarx can reseve the target memory
                                    address preventing other CORE from
                                    modifying it.<br>
                                    <br>
                                  </div>
                                  <div>I assume that there is atomtic
                                    operation executing on the CORE0 in
                                    a multicore system. In this
                                    situation, does the CORE0 disable
                                    the local HW interrupt?<br>
                                  </div>
                                  <div>Can the executing process from
                                    the beginning of lwarx and end of
                                    stwcx be interrupted by HW
                                    interruptions/exceptions?&nbsp; Anyway,
                                    they are two assembly instructions.<br>
                                  </div>
                                </div>
                              </blockquote>
                              <br>
                            </div>
                            It should just like other arch, the
                            processor should response any interrupt
                            after the execution of a instruction, so the
                            local HW interrupt is not disabled.<br>
                            <br>
                            Thanks<br>
                            Wei<br>
                            <blockquote type="cite">
                              <div>
                                <div dir="ltr">
                                  <div> <br>
                                    &nbsp;Thanks a lot!<br>
                                  </div>
                                  <div><br>
                                    "1:&nbsp;&nbsp;&nbsp; lwarx&nbsp;&nbsp;&nbsp; %0,0,%2&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #
                                    atomic_inc\n\<br>
                                    &nbsp;&nbsp;&nbsp; addic&nbsp;&nbsp;&nbsp; %0,%0,1\n"<br>
                                    "&nbsp;&nbsp;&nbsp; stwcx.&nbsp;&nbsp;&nbsp; %0,0,%2 \n\<br>
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
<a moz-do-not-send="true" href="mailto:Linuxppc-dev@lists.ozlabs.org" target="_blank">Linuxppc-dev@lists.ozlabs.org</a>
<a moz-do-not-send="true" href="https://lists.ozlabs.org/listinfo/linuxppc-dev" target="_blank">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
                            </blockquote>
                            <br>
                          </div>
                        </blockquote>
                      </div>
                      <br>
                    </div>
                  </blockquote>
                  <br>
                </div>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------000600030300080402090605--
