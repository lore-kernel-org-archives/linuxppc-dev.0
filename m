Message-ID: <3D42D1B1.20103@dslextreme.com>
Date: Sat, 27 Jul 2002 10:00:33 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Todd Poynor <tpoynor@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] ppc4xx_pm.c
References: <3D3DD903.3070300@dslextreme.com> <3D41DCB4.90706@dslextreme.com> <3D41E388.1090506@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Todd Poynor wrote:
>  > +++ b/drivers/net/ibm_ocp/ibm_ocp_enet.c
>  >
>
>>      for (curr_emac = 0; curr_emac < emac_max; curr_emac++) {
>> +        if(ocp_get_pm(EMAC, curr_emac)){
>> +            mtdcr(DCRN_CPMFR,
>> +                  mfdcr(DCRN_CPMFR) & ~IBM_CPM_EMAC(ocp_get_pm(EMAC,
>> curr_emac)));
>> +        }
>>          ocp_enet_probe(curr_emac);
>>      }
>>
>> @@ -1193,6 +1199,17 @@
>>  static void __exit
>>  exit_ppc405_enet(void)
>>  {
>> +    int i;
>> +    struct ocp_dev *emac_dev;
>> +
>> +    for (i = 0; i < ocp_get_max(EMAC); i++) {
>> +        emac_dev = ocp_get_dev(EMAC, i);
>> +        if(ocp_get_pm(EMAC, i)){
>> +            mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) |
>> IBM_CPM_EMAC(ocp_get_pm(EMAC, i)));
>> +            ocp_unregister(emac_dev);
>> +        }
>> +    }
>> +
>
>
> (1) Also do CPM on/off at open/close hooks, so that closed EMACs are
> powered down and powered back up when re-opened?

This idea should be applied to all ocp drivers.  I am not sure if
forcing (CPMFR) it the best method @ open/close or requesting/enabling
power down (CPMER).  mmm... gota think about :)

>
> (2) Move ocp_unregister() call outside "if(ocp_get_pm()" test.
Thanks

>
>


Armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
