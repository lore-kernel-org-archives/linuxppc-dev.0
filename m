Date: Fri, 19 Sep 2003 01:24:14 -0500
Subject: Re: question about UART ST16C2552
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: <linuxppc-embedded@lists.linuxppc.org>
To: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <200309190129.h8J1TcaJ006055@motgate5.mot.com>
Message-Id: <E38F02EC-EA69-11D7-BE06-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Acutally, I misunderstood your question.  The patch I've listed below
is to make the DUART on 8241/8245/8540 be detected correctly as a
16550A.  The current code detects it as a startech uart.


diff -u -3 -t -p -r1.1.1.1 serial.c
--- serial.c    2003/09/05 22:29:42     1.1.1.1
+++ serial.c    2003/09/19 06:22:09
@@ -3741,13 +3741,17 @@ static void autoconfig(struct serial_sta
                  /* Check for Startech UART's */
                  serial_outp(info, UART_LCR, UART_LCR_DLAB);
                  if (serial_in(info, UART_EFR) == 0) {
-                        state->type = PORT_16650;
+                        serial_outp(info, UART_EFR, 0xA8);
+                        if (serial_in(info, UART_EFR) != 0)
+                                state->type = PORT_16650;
+                        serial_outp(info, UART_EFR, 0);
                  } else {
                          serial_outp(info, UART_LCR, 0xBF);
                          if (serial_in(info, UART_EFR) == 0)
                                  autoconfig_startech_uarts(info, state,
flags);
                  }
          }

- kumar

On Thursday, September 18, 2003, at 08:39 PM, Yuxiao Xi wrote:

> Yes,I have an external DUART ST16C2552.
> Kumar,should ST16C2552 be detected as 16550A?
> When and where can I get the patch for the on-chip UART you said?
> Thanks.
>
>
>
>
>
>> Thanks for the correction.  I guess my comments really apply to 8241,
>> 8245 and 8540 then.
>>
>> - kumar
>>
>> On Thursday, September 18, 2003, at 11:23 AM, Milliorn Gary-rxcr80
>> wrote:
>>
>>> Kumar,
>>>
>>>   There is no DUART on the MPC8240, if 8240 is what he literally
>>> meant.  Some boards, like Unity, used to have an external DUART
>>> for this reason.
>>>
>>> Gary Milliorn
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Kumar Gala [mailto:kumar.gala@motorola.com]
>>>> Sent: Thursday, September 18, 2003 11:01 AM
>>>> To: Yuxiao Xi
>>>> Cc: linuxppc-embedded
>>>> Subject: Re: question about UART ST16C2552
>>>>
>>>>
>>>>
>>>> For 824x the detection code for the on-chip UART does NOT currently
>>>> detect it as a 16550A.  There is a patch that Tom Rini and I are
>>>> working on getting accepted by the serial maintainers, that should
>>> fix
>>>> this.
>>>>
>>>> However, its not clear to me from your email if you also have a
>>>> ST16C2552 in addition to the DUART on the 8240.
>>>>
>>>> - kumar
>>>>
>
>
>
> ¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡Yuxiao Xi
> ¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡xiyuxiao@harbournetworks.com
> ¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡2003-09-19


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
