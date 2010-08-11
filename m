Return-Path: <crmanik@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 69ADCB70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 08:18:40 +1000 (EST)
Received: by wyb42 with SMTP id 42so653775wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Aug 2010 15:18:37 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Aug 2010 15:18:37 -0700
Message-ID: <AANLkTikrpqFQsK=YLkHeWc1ZC=_Gz2rWStJrbQ8O-SrZ@mail.gmail.com>
Subject: Query regarding 2.6.335 RT[Ingo's] and Non-RT performance
From: Manikandan Ramachandran <crmanik@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016365eebd893b1d7048d93a13e
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016365eebd893b1d7048d93a13e
Content-Type: text/plain; charset=ISO-8859-1

Hello All,

    I created a very simple program which has higher priority than normal
tasks and runs a tight loop. Under same test environment I ran this
program on both non-rt and rt 2.6.33.5 kernel.  To my suprise I see that
performance of non-RT kernel is better than RT. non-RT kernel took 3 sec and
366156 usec while RT kernel took about 3 sec and 418011 usec.Can someone
please explain why the performance of non-rt kernel is better than rt
kernel? From the face of the test result, I feel RT has more overhead,Is
there any configuration that I could do to bring down the overhead?

Processor:
----------------
processor       : 0
cpu             : 7448
clock           : 996.000000MHz
revision        : 2.2 (pvr 8004 0202)
bogomips        : 83.10
processor       : 1
cpu             : 7448
clock           : 996.000000MHz
revision        : 2.2 (pvr 8004 0202)
bogomips        : 83.10

CFS optimization:
--------------------------
# cat /proc/sys/kernel/sched_rt_runtime_us
1000000
# cat /proc/sys/kernel/sched_rt_period_us
1000000
# cat /proc/sys/kernel/sched_compat_yield
1

Test Program:
---------------------

main()
{

    int sched_rr_min,sched_rr_max;
    struct sched_param scheduling_parameters;
    struct timeval tv,late_tv;
    suseconds_t usec_diff,avg_usec = 0;
    time_t sec_diff, avg_sec = 0;
    int i;
    long count = 1;

    sched_rr_min = sched_get_priority_min(SCHED_RR);
    sched_rr_max = sched_get_priority_max(SCHED_RR);
    scheduling_parameters.sched_priority = sched_rr_min+4;
    sched_setscheduler(0, SCHED_RR, &scheduling_parameters);// Run the
process with the given priority


    for(i = 0 ; i < 150 ; i++) {
       gettimeofday(&tv, NULL);
       while(count > 0){
        //printf(".");
        count++;
       }
       gettimeofday(&late_tv, NULL);
       count = 1;
       sec_diff = (late_tv.tv_sec - tv.tv_sec);
       avg_sec += sec_diff;
       usec_diff = ( (late_tv.tv_usec > tv.tv_usec) ? (late_tv.tv_usec -
tv.tv_usec) : ( tv.tv_usec - late_tv.tv_usec));
       avg_usec += usec_diff;
       printf("Iteration #%d sec %x usec %x\n",i,(sec_diff),(usec_diff));
    }
       printf("Average of #%d sec %x usec %x\n",i,(avg_sec/i),(avg_usec)/i);
}

Partial Result of non-rt kernel:
-------------------------------------------

Iteration #140 sec 3 usec 3aef8
Iteration #141 sec 3 usec 3aefe
Iteration #142 sec 3 usec 3aee4
*Iteration #143 sec 4 usec b935b  [Why there is this periodic bump ??]
[Scheduler at work??]*
Iteration #144 sec 3 usec 3aef2
Iteration #145 sec 3 usec 3aef0
Iteration #146 sec 3 usec 3aef4
*Iteration #147 sec 4 usec b934b*
Iteration #148 sec 3 usec 3aeed
Iteration #149 sec 3 usec 3aef9

 Partial Result of rt kernel:
-------------------------------------------
Iteration #135 sec 3 usec 47328
*Iteration #136 sec 4 usec ac4fd
*Iteration #137 sec 3 usec 48b0b
Iteration #138 sec 3 usec 4738c
Iteration #139 sec 4 usec ac4d5
Iteration #140 sec 3 usec 483cb
Iteration #141 sec 3 usec 48500
*Iteration #142 sec 4 usec acc49
*Iteration #143 sec 3 usec 47c1f
Iteration #144 sec 3 usec 478c2
Iteration #145 sec 3 usec 47e48
Iteration #146 sec 4 usec ac9b5
Iteration #147 sec 3 usec 48de4
Iteration #148 sec 3 usec 46fbe
Iteration #149 sec 4 usec ac52e
Average of #150 sec 3 usec 660db

Thanks,
Mani


-- 
Thanks,
Manik

Think twice about a tree before you take a printout

--0016365eebd893b1d7048d93a13e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">Hel=
lo All,</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010"></s=
pan></font>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">=A0=
=A0=A0 I=A0created a very simple program which has higher priority than nor=
mal tasks and runs a tight loop. Under same test environment I ran this pro=
gram=A0on both non-rt and rt=A02.6.33.5 kernel.=A0</span></font><font size=
=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">=A0To my suprise I=
 see that performance of non-RT=A0kernel is better than RT. non-RT=A0kernel=
 took 3 sec and 366156 usec while RT=A0kernel took about 3 sec and 418011 u=
sec.Can someone please explain why the performance of non-rt kernel is bett=
er than rt kernel? From the face of the test result, I feel RT has more ove=
rhead,Is there=A0any configuration that I could do to bring down the overhe=
ad?</span></font></div>

<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010"></s=
pan></font>=A0</div>
<div>Processor:</div>
<div>----------------</div>
<div>processor=A0=A0=A0=A0=A0=A0 : 0<br>cpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 : 7448<br>clock=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 996.000000MHz<br>rev=
ision=A0=A0=A0=A0=A0=A0=A0 : 2.2 (pvr 8004 0202)<br>bogomips=A0=A0=A0=A0=A0=
=A0=A0 : 83.10</div>
<div>processor=A0=A0=A0=A0=A0=A0 : 1<br>cpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 : 7448<br>clock=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 996.000000MHz<br>rev=
ision=A0=A0=A0=A0=A0=A0=A0 : 2.2 (pvr 8004 0202)<br>bogomips=A0=A0=A0=A0=A0=
=A0=A0 : 83.10</div>
<div>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">CFS=
 optimization:</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">---=
-----------------------</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010"># c=
at /proc/sys/kernel/sched_rt_runtime_us <br>1000000<br># cat /proc/sys/kern=
el/sched_rt_period_us=A0 <br>1000000<br># cat /proc/sys/kernel/sched_compat=
_yield <br>
1</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010"></s=
pan></font>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">Tes=
t Program:</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">---=
------------------</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010"></s=
pan></font>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">mai=
n()<br>{</span></font></div>
<div><font size=3D"2" face=3D"Arial"></font>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">=A0=
=A0=A0 int sched_rr_min,sched_rr_max;<br>=A0=A0=A0 struct sched_param sched=
uling_parameters;<br>=A0=A0=A0 struct timeval tv,late_tv;<br>=A0=A0=A0 suse=
conds_t usec_diff,avg_usec =3D 0;<br>
=A0=A0=A0 time_t sec_diff, avg_sec =3D 0;<br>=A0=A0=A0 int i;<br>=A0=A0=A0 =
long count =3D 1;</span></font></div>
<div><font size=3D"2" face=3D"Arial"></font>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">=A0=
=A0=A0 sched_rr_min =3D sched_get_priority_min(SCHED_RR);<br>=A0=A0=A0 sche=
d_rr_max =3D sched_get_priority_max(SCHED_RR);<br>=A0=A0=A0 scheduling_para=
meters.sched_priority =3D sched_rr_min+4;<br>
=A0=A0=A0 sched_setscheduler(0, SCHED_RR, &amp;scheduling_parameters);// Ru=
n the process with the given priority</span></font></div>
<div><font size=3D"2" face=3D"Arial"></font>=A0</div><font size=3D"2" face=
=3D"Arial"><span class=3D"371554521-11082010">
<div><br>=A0=A0=A0 for(i =3D 0 ; i &lt; 150 ; i++) {<br>=A0=A0=A0=A0=A0=A0 =
gettimeofday(&amp;tv, NULL);<br>=A0=A0=A0=A0=A0=A0 while(count &gt; 0){<br>=
=A0=A0=A0=A0=A0=A0=A0 //printf(&quot;.&quot;);<br>=A0=A0=A0=A0=A0=A0=A0 cou=
nt++;<br>=A0=A0=A0=A0=A0=A0 }<br>=A0=A0=A0=A0=A0=A0 gettimeofday(&amp;late_=
tv, NULL);<br>
=A0=A0=A0=A0=A0=A0 count =3D 1;<br>=A0=A0=A0=A0=A0=A0 sec_diff =3D (late_tv=
.tv_sec - tv.tv_sec);<br>=A0=A0=A0=A0=A0=A0 avg_sec +=3D sec_diff;<br>=A0=
=A0=A0=A0=A0=A0 usec_diff =3D ( (late_tv.tv_usec &gt; tv.tv_usec) ? (late_t=
v.tv_usec - tv.tv_usec) : ( tv.tv_usec - late_tv.tv_usec));<br>
=A0=A0=A0=A0=A0=A0 avg_usec +=3D usec_diff;<br>=A0=A0=A0=A0=A0=A0 printf(&q=
uot;Iteration #%d sec %x usec %x\n&quot;,i,(sec_diff),(usec_diff));<br>=A0=
=A0=A0 }<br>=A0=A0=A0=A0=A0=A0 printf(&quot;Average of #%d sec %x usec %x\n=
&quot;,i,(avg_sec/i),(avg_usec)/i);<br>}</div>

<div></div></span></font><font size=3D"3" face=3D"Times New Roman">=A0</fon=
t>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">Par=
tial Result of non-rt kernel:</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">---=
----------------------------------------</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010"></s=
pan></font>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">Ite=
ration #140 sec 3 usec 3aef8<br>Iteration #141 sec 3 usec 3aefe<br>Iteratio=
n #142 sec 3 usec 3aee4<br><strong>Iteration #143 sec 4 usec b935b=A0 [Why =
there is this periodic bump ??] [Scheduler at work??]</strong><br>
Iteration #144 sec 3 usec 3aef2<br>Iteration #145 sec 3 usec 3aef0<br>Itera=
tion #146 sec 3 usec 3aef4<br><strong>Iteration #147 sec 4 usec b934b</stro=
ng><br>Iteration #148 sec 3 usec 3aeed<br>Iteration #149 sec 3 usec 3aef9</=
span></font></div>

<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010"></s=
pan></font>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">Par=
tial Result of rt kernel:</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">---=
----------------------------------------</span></font></div></span></font><=
/div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">Ite=
ration #135 sec 3 usec 47328<br><strong>Iteration #136 sec 4 usec ac4fd<br>=
</strong>Iteration #137 sec 3 usec 48b0b<br>Iteration #138 sec 3 usec 4738c=
<br>
Iteration #139 sec 4 usec ac4d5<br>Iteration #140 sec 3 usec 483cb<br>Itera=
tion #141 sec 3 usec 48500<br><strong>Iteration #142 sec 4 usec acc49<br></=
strong>Iteration #143 sec 3 usec 47c1f<br>Iteration #144 sec 3 usec 478c2<b=
r>
Iteration #145 sec 3 usec 47e48<br>Iteration #146 sec 4 usec ac9b5<br>Itera=
tion #147 sec 3 usec 48de4<br>Iteration #148 sec 3 usec 46fbe<br>Iteration =
#149 sec 4 usec ac52e<br>Average of #150 sec 3 usec 660db</span></font></di=
v>

<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010"></s=
pan></font>=A0</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">Tha=
nks,</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"371554521-11082010">Man=
i</span></font></div><br clear=3D"all"><br>-- <br>Thanks,<br>Manik<br><br>T=
hink twice about a tree before you take a printout<br>

--0016365eebd893b1d7048d93a13e--
