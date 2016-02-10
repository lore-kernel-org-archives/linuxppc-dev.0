Return-Path: <fengguang.wu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 24B571A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 03:20:35 +1100 (AEDT)
Date: Thu, 11 Feb 2016 00:20:06 +0800
From: kbuild test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: kbuild-all@01.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc32: provide VIRT_CPU_ACCOUNTING
Message-ID: <201602110035.8fpYwPxV%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
In-Reply-To: <20160210145848.01F031A2446@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christophe,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.5-rc3 next-20160210]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc32-provide-VIRT_CPU_ACCOUNTING/20160210-230049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:30:0:
   arch/powerpc/kernel/asm-offsets.c: In function 'main':
>> include/linux/compiler-gcc.h:158:2: error: 'struct thread_info' has no member named 'starttime'
     __builtin_offsetof(a, b)
     ^
   include/linux/kbuild.h:5:55: note: in definition of macro 'DEFINE'
            asm volatile("\n->" #sym " %0 " #val : : "i" (val))
                                                          ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
>> arch/powerpc/kernel/asm-offsets.c:260:25: note: in expansion of macro 'offsetof'
     DEFINE(PACA_STARTTIME, offsetof(struct thread_info, starttime));
                            ^
>> include/linux/compiler-gcc.h:158:2: error: 'struct thread_info' has no member named 'starttime_user'
     __builtin_offsetof(a, b)
     ^
   include/linux/kbuild.h:5:55: note: in definition of macro 'DEFINE'
            asm volatile("\n->" #sym " %0 " #val : : "i" (val))
                                                          ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/kernel/asm-offsets.c:261:30: note: in expansion of macro 'offsetof'
     DEFINE(PACA_STARTTIME_USER, offsetof(struct thread_info, starttime_user));
                                 ^
>> include/linux/compiler-gcc.h:158:2: error: 'struct thread_info' has no member named 'user_time'
     __builtin_offsetof(a, b)
     ^
   include/linux/kbuild.h:5:55: note: in definition of macro 'DEFINE'
            asm volatile("\n->" #sym " %0 " #val : : "i" (val))
                                                          ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/kernel/asm-offsets.c:262:25: note: in expansion of macro 'offsetof'
     DEFINE(PACA_USER_TIME, offsetof(struct thread_info, user_time));
                            ^
>> include/linux/compiler-gcc.h:158:2: error: 'struct thread_info' has no member named 'system_time'
     __builtin_offsetof(a, b)
     ^
   include/linux/kbuild.h:5:55: note: in definition of macro 'DEFINE'
            asm volatile("\n->" #sym " %0 " #val : : "i" (val))
                                                          ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^
   arch/powerpc/kernel/asm-offsets.c:263:27: note: in expansion of macro 'offsetof'
     DEFINE(PACA_SYSTEM_TIME, offsetof(struct thread_info, system_time));
                              ^
   make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +158 include/linux/compiler-gcc.h

cb984d10 Joe Perches 2015-06-25  152  #  error Your version of gcc miscompiles the __weak directive
cb984d10 Joe Perches 2015-06-25  153  # endif
cb984d10 Joe Perches 2015-06-25  154  #endif
cb984d10 Joe Perches 2015-06-25  155  
cb984d10 Joe Perches 2015-06-25  156  #define __used			__attribute__((__used__))
cb984d10 Joe Perches 2015-06-25  157  #define __compiler_offsetof(a, b)					\
cb984d10 Joe Perches 2015-06-25 @158  	__builtin_offsetof(a, b)
cb984d10 Joe Perches 2015-06-25  159  
cb984d10 Joe Perches 2015-06-25  160  #if GCC_VERSION >= 40100 && GCC_VERSION < 40600
cb984d10 Joe Perches 2015-06-25  161  # define __compiletime_object_size(obj) __builtin_object_size(obj, 0)

:::::: The code at line 158 was first introduced by commit
:::::: cb984d101b30eb7478d32df56a0023e4603cba7f compiler-gcc: integrate the various compiler-gcc[345].h files

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tThc/1wpZn/ma/RB
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICIpiu1YAAy5jb25maWcAjFxZk9u4rn6fX6GauQ8zVXeSXrPUrX6gKcpirC0kZbvzonLc
SuJKt93Hds8k//4CpGxrAZ1zqqZOmoC4gCDwAQT9x29/BOxlv3la7FfLxePjz+Brva63i339
EHxZPdb/F4R5kOUmEKE0r4A5Wa1ffrx+3vxbb5+Xwc2r21cXf2+X18Gk3q7rx4Bv1l9WX1+g
g9Vm/dsf8AHPs0iOq6Lgb26C1S5Yb/bBrt7/ZonFdrOsd7vNNti9PD9vtntoPX1QjfJ8cq2r
66u7n52eqne3P360O+sSPbSbC0/7Dd0uri4u2oTBxGBWTdubHz9OfyBDVJTtObPEyKngnt60
Cas0Lbs9NI3E4tO00onkQnu6i9lUVAV8qsuiyJVpf6/Twiu3MM/VSCQJ0e001LmdSPM3L8pq
hCLKQsmyzsTbbNdXI2lOf85yFVZafhJ311ct2SgeV0V8rysWhqoy1Zsb+IqcpWUNU+blbPic
MI+fWYFoYcqiKoSyk2dKMHKITIjwyCXSEfwVSaVNxeMymxBjZaqS6qO+u728OjRpw/jEKMZF
awsammuGL6KEjfWQnuR8EopiSFAzLdJqzuMxLB4UapwraeL0xGCFEzNdySQfX1VleyPGIhNK
gmrMhBzHhvgIpQoiqngeCyUyU6VMTzob25booT+uy5SQiWAqua8KJTPT7oNl8ImRqchLc3f5
7qI/u2yqWGtBmscg/TyVpoqAADqdQ4dC9WafsvtG5eHYhbx/WspwNK4u39zeXpD7fRjbjPR9
Rh1QVoLlsyO1exYFKxSaAVpRQxGxMjFVKVM2FlSvVu5yJFTGjMwzWJvWcpSI/vRDripkmQr/
uQWWNJW5b5hGlWCPxajEbRgLloCe9eR4ZCsLlY9Ey7oVY8NgalUipiLRd0c9h1UetFZqc/f7
68fV59dPm4eXx3r3+n/KDPdMiUQwLV6/WlrP8Luz+2PrZB5xqi/PJ5s/UvlEZBWIA+zUaXyZ
wQ6IbArzxKFAIdCAHEyRAsmB2qaFBOn9/vtJNk1bZYSmjARIgCVToTSIv/NdmwDbbyjBHjY4
zrXBdd79/ud6s67/anWj7/VUFpzcNjfpVKS5uq+YAXsRk3xRzLIwobe+1CKRI2Ju9jDYLbW6
C/OA9SQgTit6MD3gbD/vfu729dNJ9IdzAORKx/lsaDsOFKcGrd2B9jBPmcy6bVGuOJxfE4Op
DWU2bh3sgiltjeBwFDQP1bSZc5Un4ZCFo42EOWRGE8Q0Rw0OmRGHFZvVU73dUYuOP6Gpl3ko
O2Yjy5EifYK3ZJISg3EFjdd2FUoP4A74lNdmsfse7GFKwWL9EOz2i/0uWCyXm5f1frX+epqb
kXziXBXneZkZJ8HjUFOpTI9M2Ak7quJloIeLh0/uK6C1e4U/KzEHmdBmzYBP0MhEUvFjcH2w
bXDy0jyju1BCWE7rCL394CRAd4XfxI5KmYQAQrIr+ojJifsHff7GKi8LTdNiwSfW1eBWmlzR
s3TeCc2D7YteiUjYPT37ZAI2ZGpNmwrpefAqL0CRAC/hWbLAiTjteFRMAgLjorCexAr2dDDc
drY3OQXDJcF6KHpdY2HQ91fNGaSZ7nWkz3JMgKDvU1rEDhl4tpXesRE4kSoqPaNFpRFzGsQX
uW8NcpyxJKKFbw+wh2ZNj4c2KqLzgovB6NPYtuvAT+3hVMLSm05peeJmWn/kmVXBZfWxlGpC
fw5TGjGlZFcjDqtFDByKlh12YAtGrI5G2NqZJgQs6u2XzfZpsV7WgfinXoN9Y2DpOFo4sMOd
oPDUCTmxaeqolTVxPYva8fPMAHigNUonjPKSOilHncgoyUc+XTeAvMGjsApQgYwkt5DNo9l5
JBMwxj6/nDuODs77UKZFBbMUtM40eIz2ONinDYMgJACFRpPEITSkYkPLKyKYv0SZAj7rfNGD
g6BT1saCm6hGesaKngJIMIwpK3DFpkea9AGka1XCkAQ7nLVaMYTVQ5cOWNA64wZK9L5WAsIo
QEku6mrWUrFC9vhs2FhIB4KpGZx2YRAeAUuWykqzSADAKDAI6/HMGEgU0F7loM0BVhLDaMFR
YSGqTFws0zb4dg0oUcHB8fj2kPD9vZHSPGxGKwRHjT3RgVQmAFFwf0USWR/V31pAb2IOKgXe
xKI+nBURM9rPQfQ5+qhWciDJM9Ad+GbGVNjabUBzaHV1CbPKwkE748bJzIUIPJ/+/Xmxqx+C
786wPG83X1aPHZB0nApyN4cP5GzRbveMHJQJ1eAQ4xLytW5Gp9jDZctAOpl5PDmgUaInmYEZ
gL4KOD9lhkxdwNvQUaMb+jka+e1MIULyfNwmdr/uRnvMwPbxSqWztswigGmfPAgBY8655B7X
DkTJi1/FrMgST8+QAWYC2vSE7FVUjDvpG5dMfFzs0fO0comdTnms/MmvtOC3l1f+pCLSr84k
HYuU0TjUjiw8cOBA/JW43nmH/njFQv9OvLs+lyd94yEeXL6PzlI4rHDGaeAHTntc9kLuXt4E
jCRDI+adWh5Z4I9eIQUAJz1jyULSQk99BOzczSEGe3Hm62ompAeYWwV9d3X73kv1qi6maVya
yz9weV3FxuYUzynj5cUbL/n92wtQKL+uF2/75EN0GkTb+j8v9Xr5M9gtF42tPTkocDlgGD5S
X8qHxzp42K7+qbfQdOwPm/tdeANra5gwAauPfIj8ikR4QDqjA9FIJ1WZyMvbt7ce5J9Cn9W4
6ELuNojdPOMFRgesYnDvA+/xp+qSvCwAwtXtRccbfaquL+hcpOuF7uYOuukHn7HCJAF1CwDW
Oy1MlcEh7SQUm/ZpngBsYIqOTRsuyjvKLEoN+v12r02r5koW9JF26CcvPZG8+z6V2pMsA6QZ
lp6LC5njJUksksIXz85kbhIqArDqJjKb2mxScXFuiqTsgzsEGDMGEbvj6lEHPQAuzqcduU/E
XPgSgUzHVX917e6jhBnouxnmNHbT3m2AHQ/tVKp0ANgxyusihU5z8+ngswNwwqzMuGxRs9za
aDeH7lY37QBFotz2S8VfRQIIszB2bDju+u6mF9Jxb5QF/kedicHO3SU1PJ8QoiIWxGsYgHqH
gBORtYGFlbqzf5q65TjkgFMMg1KAeTjm3c3F+zdHEbUvkyYdOfFEsIwzOMe0XqT09dSnIs9p
KPFpVNJW8pOFs7nv8vFmYm8EWjDdJm5BE+ZWSrkKIUy5bKFhC1owjrVo2TP90ILQUW+2BxQw
B8cO5luNhdGd3HtBCVpqdgjfDtHB6GXXstG9Te3kcnEL8GPcJAhkDKWLlkmPLV8isrGJifS3
m0T/fkZmoVQQrWGOhZIwb8WhmIZxmXLdbTyl6NspG4EAHTTRm9JJtfTSbJjrpSp3A3SwXf1L
jg6vNiWdGEGizD0gHmiF8k+vYFp21NUheJDht81uHyw36/128/hYbxtM0U0bcc482AxNtQI9
CT3ZtHM08JaoILDXE6GybjLGDs8e/sGs1gO22GurdpIOTjPeVtoc7DDzH9ZfFi+PtgHT/LsA
ApVgcehv2a6aOOh1sNjWwQvEvycFT/IZmlV7hX7xA2CE/d/pfhUiozyKtDBAXfaobk14BBRF
RqMpQQmPDBc9BmNzwm7k48dd6OZyAbRsBWWFnbMoouqDLRNoJPXPalkH4XHbTxeGq2XTHORD
eFa6TOEZJBCKqUmLiD5PsOwsZIkvqgFMZLuPJATKTLnUGK2C0Qz2iYWeSeC5m9nU/1lY465q
QwVBoW8xlkFMlScvATaliu9BFlOpc7qP450ZeCfoqV9SchoLawNiWHUIy46i7oyO5vjBblxn
T1ITErsemlY6Ku9ASYj7ykwaz40tUBHk4BVSu4Om3IAkoUvu5DZPbV3bDO2dJAn83adbe9fj
gY5AwiCYHgwCEmBA1bv+aR+WFAsxjoULEBH3S3WapoGs09VuSQkbdCm9xwl6QBHLjOdw6jEa
cn5DEo2MUqurdDyf8STXpcL6GuXXoLjAqhR6cF8wzK/I5QsByCOlcjyOUr2/5nM6Nuajt5cX
g7W4O+L6x2IXyPVuv315sncWu29gfx+C/Xax3uFIAUTDEOGC8FfP+M+DZWKP+3q7CGxG6stq
+/Qvmu2Hzb/rx83iIXDVEAdeud5DbJlKbg9M2ImWNZcR0Xz6JEbH6CPyxfaB6tDLv3k+lt7p
/WJfB+livfha49qDP3mu079aJvgkYh7Tu8jnyRk0CMTG/YD79bIIEft8hAyPt/maA+px6j8s
GkQiZms7FzvYFnrwdFTqXhjhBCWECC6v398Ef0arbT2D//6iVA7cgZhJz9k4EAFYaDrSThmX
cCoxArSWfogb5Pr5ZT9c7in8zYpyeEZi0Aarh/J1HuAnnU3UWPLw35kly9op/GKpII8lh+Oy
WO4RsA1NkzH0+sHp+DIqQJr4aLJIZeUqY2jHFs/OYhFv/g0cYqUMHamzAgJW7unScPiPjF1g
HX3DPpdJct/D9W6zrzi5x54KB+05SxrEQ4ulGy84yF1oOl8+nB62NdXBG1tPc/jKUU0RLB83
y+99glgvPj/WAQBMLFfCohcAg7NcTRBz2ot2wF5pgXem+w2MVgf7bzVg44cVYrzFo+t196p3
62Nv3BzcBtSKuTzovqOqromUxOySdpL5DIJ1vBpJPKkxy4BO35O7tnQ29XjBmbcqJhYKonR6
rszwOMypG2WtR+3CQWcfN+vVchfo1eMKwopgtFh+f35crDtZWPiOyu5xwHn97kZbcGPLzVOw
e66Xqy8AwVk6Yu3ORr1chQMpEOysvryslzaiaewXEcqlUegHF0jEJFcC2E7MfWfvxBUnPPRk
9IEnlm9uri6rAt0fuTuG27CUX5PkxF5L0WV6SNMeGg79gWWfsDLNF3kiz0SkhSeiQHJq3ly/
f+slq5BfX13SJTCWbvS8n6LoMOj09oI+FGw0v70Ywqbu1/ea+3J1QDayYun19e28MpqzM3tk
0jMSms7f3dIJfSXGJaB/T5iTilCyw4XnQFPH28XzNzwxhBVkYzo6m44ZGCHatIQqHYwRbRdP
dfD55csX8I/h0D9GdFd4hZ5YfwyKTS2gPaFBbut02vMyo+KwEqxHHkNQk0DElYhBMT/SB2Xo
2HhMise8g7TKrlmxK8Q2C58fugE9thfffu7w1UmQLH7SmR4cDbyEJ11TWPqcC0knoZA6ZuHY
Y6zLGS32NPUoqEh1/8KlleDAwljPVawrSpEjCZKmAkIRMn64iNdc2cKkNol4yIHt9FkwWCHL
tDeUPxfps3IeSl34qhZLz+m0aXMfhJ2utuAEqN3Fz2TuNUsNuV/a3gTBy+1mt/myD+Kfz/X2
72nw9aWG+Ig4xHAwxr2CrC5I1s+rtQUuPRXltlFvXra073JOp/C8VQFQb4sIwe7/giE15dV5
DpPSF50ibRhALz0BhkxGOe0W3M2Zzyyq+mmzrzFIpJauja0xgvEVxNx8+PXz0+5rX54aGP/U
tgo5yNcQMaye/zrBCiLa1GU2l/4EAfRXedZdpAi8+3fVJ7nNjddd2Ws8WmC+vLGh7QjENpU3
fT8jLzrURx7L1h0bU2k1BqOAlzGZapckGX3zDryyL90jCyyG841uASx49MyoPPEFUVE63Fe0
xe1S8kEq0WesEeoXc1ZdvctSjEM81RltLrDe9LEAwFlNAPVbjrMjAuS7urro+6UuWueeQomU
D51Zu7T1CXD2vvNw8SReT/WHicERCzXKk+F5Y+uH7Wb10LEvWahySUPCzBs4a+NtdylCLxVw
Al78QYvOPRUa+P4qgXUMEQ6mvzqPP0FPhukSqmwrWkF06DSqC4o0BiNyDt7TU/SNtX54fdyz
7q0estzIyJN7OEOTjlZ5i+Qjdubrj2Vu6GyTpXBDLwcv4SJ9U3kuKCIs2PTQmlRzj+yEuVh+
64FNPbh2dsq9q18eNvbVL7EbaOZ9w1saGK4kVIK2qpj981284FMCOiArAbklI3uvRTK4/wM9
8XSAFSVWS1wJN82UeWrqRzJjqnnEGA2Elaw+bxfbn8F287JfrevWJfRIGrwrUrpTAXKq/z3R
CQdwLHk2KuMFbCgmtFELiapoYElE5qG6u9lONcfxIruT0OMKto5DAEBLWPFLTy4dvjOXF6GM
vGRpyoq6xgFa91Gzbai0SCLPxU/DgI+eR/fviE8dhb7AaFiYmvkCJMfhe3QMVDruTuTIfumr
7OHvPOf88KD08HKh2RnaVds8pkc8R675J8A7dAeOBE7zAyFY+1w475QRuSbEhP1iIN3UP/T0
ycUtb26IoqkDyc5ARtaeY51rZwdzFXrWHoa09cWa9P6zntOeRGH3xXtTakQwH+ep8dWXe8DY
LgL8tlh+dyWQtvV5u1rvv9sM5sNTDfh2UICSQpSHl/BJPraPJA8lQnc3jTHePD2Def3bPv8D
u7z8vrPdLV37lio7dBe9WElFQ1lXwTFjKgPWQgkOWu55t9QUqpX2NbsgKwfdQ2vs7e7y4uqm
DRCULCqmASb4XnVhuborJ9E0BCkzMFaYLEoBAnlcia1hmGVnb7275v6gnwLv3LVbWVsB3Dda
2HIy9AkpJlRpX9RjcmLNM082uJmNLZeaCTY5lHp5QjEE8uCJuoi905W7JDtoYQohGLiYsP78
8vVrrxTXygnCGJH17696szu+9j7Dk48+wMK9T4aauYGVSGCRQ9EeKGdGcG9zSu3z5I5r6rsK
QmJTX4kPJs9P1I6FiChK8hmhCG3yuSnHvdiqqU6BzQiSzfL7y7M7u/Fi/bVzYBGRlgX0MnzE
0xoCiYBwMldYQzLNPpK5/5YO4O8pgLrmeUFtXodeTVlSirtBDbHXsDiy2ziRhUOL0ZMXJiIm
QhRUqgXlddLj4M9dk3HZ/W/w9LKvf9Twj3q/fPXq1V9D04cvaPpvbPq6gc8/fcUrlmM2c0z4
zG8GPpc+/47XVqT6zwyg3en5uMN2gPnYM4Mcsn0JiOwXc8Gn3fhy7YAA6HXaQUHfDBZjeIHC
6adJzgw6cQbh3LSkp//G6MhfcWhaco5oYyvpe+7peLgSociMZMkw5sEH6rTVtFvne7/e/CwB
Fjo3vzRCR/G/krF93f5fMZ1/Av9Rn6niPMioEkrlCo7xB+Gvl3Z1yiRP235GZcZPT8jV3U+a
OlasiGme8D5jqNZR7xG668D99k1q3ywCWkDk12M5/O6D5bSb0CrdwkY8C0Q2PBqI0ikC/qgC
QC1T7/Y9VcCNsUpaad+lyuj0Kz740tG/lSP7owZe+hEFn4XwdkKxmHtLAi0DwrBs3FQ5erJM
yDcBRuNJ/FqGYVzbpSvAxbH92RdCW9xvL4Q516rzwxmdN7b+vsvQ+7sI4OX9tovhsx0vTLFo
fjIOO0UA+Pc55F+ONMugZ0AV+DsLvSJsSz33uStgqaR2dZ2iW3gEewVO/kyRi/31HqkdgrcH
mXLjBW+IROdpWpn7QljnTGIA3ObGi0N4YOK7Ny1Qz/HJR4EYw56rc+oJJ6yK5ByAzVm2VEsM
pG2x/dmA1VcJMQolPtnxIXR8WTIHLZr73w66atCBCroriHr5sl3tf1KB1kTcezJUgpdKGugT
4jubPLeyP8tLhiiHByOnDlmrErZP/f+hnmUUFBmAY40+aJos1NHHMwpjRwwAuUkcP91PAAA=

--tThc/1wpZn/ma/RB--
